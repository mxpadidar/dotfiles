import QtQuick
import Quickshell
import Quickshell.Io

BarButton {
    id: wifi
    property var status: ({state: "unavailable", ssid: ""})
    glyph: status.state === "offline" ? "\udb81\uddaa" : "\uf1eb"
    text: ""
    tooltip: status.state === "connected" ? status.ssid : status.state
    foreground: status.state === "connected" ? "#7dcfff" : status.state === "offline" ? "#f7768e" : "#565f89"
    onClicked: Quickshell.execDetached(["ghostty", "-e", "impala"])

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
