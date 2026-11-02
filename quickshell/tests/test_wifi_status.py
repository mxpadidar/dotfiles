import importlib.util
from pathlib import Path
import unittest
from unittest.mock import patch
import io
import json
import subprocess

spec = importlib.util.spec_from_file_location("wifi_status", Path(__file__).parents[1] / "wifi-status.py")
wifi = importlib.util.module_from_spec(spec)
spec.loader.exec_module(wifi)


class WifiStatusTests(unittest.TestCase):
    def test_connection_states(self):
        station = {"State": {"type": "s", "data": "disconnected"}}
        objects = {"/station": {"net.connman.iwd.Station": station}}
        self.assertEqual(wifi.connection_status({})["state"], "offline")
        self.assertEqual(wifi.connection_status(objects)["state"], "offline")
        station["State"]["data"] = "connecting"
        station["ConnectedNetwork"] = {"type": "o", "data": "/network"}
        objects["/network"] = {"net.connman.iwd.Network": {"Name": {"type": "s", "data": 'Home "Wi-Fi" خانه'}}}
        self.assertEqual(wifi.connection_status(objects)["state"], "connecting")
        for state in ("connected", "roaming"):
            station["State"]["data"] = state
            self.assertEqual(wifi.connection_status(objects), {"state": "connected", "ssid": 'Home "Wi-Fi" خانه'})
        del objects["/network"]
        self.assertEqual(wifi.connection_status(objects)["ssid"], "Wi-Fi")

    def test_bus_errors_return_unavailable(self):
        for error in (FileNotFoundError(), subprocess.TimeoutExpired("busctl", 3)):
            with patch.object(wifi.subprocess, "run", side_effect=error), patch("sys.stdout", new_callable=io.StringIO) as output:
                wifi.main()
                self.assertEqual(json.loads(output.getvalue())["state"], "unavailable")

    def test_malformed_reply_returns_unavailable(self):
        with patch.object(wifi.subprocess, "run", return_value=subprocess.CompletedProcess([], 0, '{"data": []}')), patch("sys.stdout", new_callable=io.StringIO) as output:
            wifi.main()
            self.assertEqual(json.loads(output.getvalue())["state"], "unavailable")
