import QtQuick
import Quickshell
import Quickshell.Io

BarButton {
    id: wifi
    property var status: ({state: "unavailable", ssid: ""})
    glyph: status.state === "offline" ? "\udb81\uddaa" : "\uf1eb"
    text: status.state === "connected" ? (status.ssid.length > 16 ? status.ssid.slice(0, 15) + "…" : status.ssid) : status.state === "connecting" ? "Connecting" : status.state === "offline" ? "Offline" : "Wi-Fi ?"
    foreground: status.state === "connected" ? "#7dcfff" : status.state === "offline" ? "#f7768e" : "#565f89"
    onClicked: Quickshell.execDetached(["alacritty", "-e", "impala"])

    Process {
        id: poll
        command: ["python3", Quickshell.env("HOME") + "/.config/quickshell/wifi-status.py"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    wifi.status = JSON.parse(text);
                } catch (error) {
                    wifi.status = {state: "unavailable", ssid: ""};
                }
            }
        }
    }
    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: if (!poll.running)
            poll.running = true
    }
}
