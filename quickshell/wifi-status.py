#!/usr/bin/env python3
"""Read iwd connection status without scanning or changing the network."""
import json
import subprocess


def connection_status(objects):
    status = {"state": "offline", "ssid": ""}
    for interfaces in objects.values():
        station = interfaces.get("net.connman.iwd.Station", {})
        state = station.get("State", {}).get("data")
        if state in ("connected", "roaming"):
            path = station.get("ConnectedNetwork", {}).get("data", "")
            network = objects.get(path, {}).get("net.connman.iwd.Network", {})
            return {"state": "connected", "ssid": network.get("Name", {}).get("data", "Wi-Fi")}
        if state == "connecting":
            status["state"] = "connecting"
    return status


def main():
    try:
        result = subprocess.run(
            ["busctl", "--system", "--timeout=2", "--json=short", "call",
             "net.connman.iwd", "/", "org.freedesktop.DBus.ObjectManager", "GetManagedObjects"],
            capture_output=True, text=True, check=True, timeout=3,
        )
        status = connection_status(json.loads(result.stdout)["data"][0])
    except (OSError, subprocess.SubprocessError, ValueError, KeyError, IndexError, TypeError, AttributeError):
        status = {"state": "unavailable", "ssid": ""}
    print(json.dumps(status))


if __name__ == "__main__":
    main()
