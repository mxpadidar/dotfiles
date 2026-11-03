import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower

ShellRoot {
    id: root
    readonly property int barHeight: 30
    property int notificationCount: 0
    Process {
        id: notificationCounter
        command: ["swaync-client", "--skip-wait", "--count"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const count = text.trim();
                root.notificationCount = /^\d+$/.test(count) ? Number(count) : 0;
            }
        }
    }
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: if (!notificationCounter.running)
            notificationCounter.running = true
    }
    readonly property var sink: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: [root.sink]
    }
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: bar
            required property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: root.barHeight
            color: "#1a1b26"
            // Each side is clipped to its half; the clock never shifts or overlaps.
            Item {
                anchors {
                    left: parent.left
                    leftMargin: 8
                    verticalCenter: parent.verticalCenter
                }
                width: Math.max(0, (parent.width - clockLabel.width) / 2 - 20)
                height: 30
                clip: true
                Row {
                    id: leftGroup
                    spacing: 2
                    Repeater {
                        model: 10
                        BarButton {
                            required property int index
                            readonly property var workspace: Hyprland.workspaces.values.find(w => w.id === index + 1)
                            text: String(index + 1)
                            active: workspace ? workspace.active : false
                            foreground: workspace && workspace.urgent ? "#f7768e" : workspace ? "#7dcfff" : "#565f89"
                            onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (index + 1) + " })")
                        }
                    }
                    Text {
                        width: Math.max(0, leftGroup.parent.width - x)
                        height: 30
                        leftPadding: 10
                        verticalAlignment: Text.AlignVCenter
                        text: Hyprland.activeToplevel ? Hyprland.activeToplevel.title : ""
                        textFormat: Text.PlainText
                        elide: Text.ElideRight
                        font {
                            family: "Hasklug Nerd Font"
                            pixelSize: 13
                        }
                        color: "#bb9af7"
                    }
                }
            }
            Text {
                id: clockLabel
                anchors.centerIn: parent
                text: Qt.formatDateTime(clock.date, "ddd dd MMM  HH:mm")
                font {
                    family: "Hasklug Nerd Font"
                    pixelSize: 13
                }
                color: "#7dcfff"
            }
            Item {
                anchors {
                    right: parent.right
                    rightMargin: 8
                    verticalCenter: parent.verticalCenter
                }
                width: Math.max(0, (parent.width - clockLabel.width) / 2 - 20)
                height: 30
                clip: true
                Row {
                    anchors.right: parent.right
                    spacing: 8
                    BarButton {
                        visible: UPower.displayDevice.ready && UPower.displayDevice.isLaptopBattery
                        interactive: false
                        text: (UPower.onBattery ? "BAT " : "AC ") + Math.round(UPower.displayDevice.percentage * 100) + "%"
                        foreground: "#e0af68"
                    }
                    WifiButton {}
                    BarButton {
                        text: !root.sink || !root.sink.audio ? "Vol ?" : root.sink.audio.muted ? "Muted" : "Vol " + Math.round(root.sink.audio.volume * 100) + "%"
                        foreground: "#bb9af7"
                        onClicked: button => {
                            if (button === Qt.RightButton && root.sink && root.sink.audio)
                                root.sink.audio.muted = !root.sink.audio.muted;
                            else if (button === Qt.LeftButton)
                                Quickshell.execDetached(["ghostty", "-e", "pulsemixer"]);
                        }
                        onScrolled: delta => {
                            if (root.sink && root.sink.audio && delta !== 0)
                                root.sink.audio.volume = Math.max(0, Math.min(1, root.sink.audio.volume + (delta > 0 ? 0.02 : -0.02)));
                        }
                    }
                    BarButton {
                        glyph: "\uf0f3"
                        text: String(root.notificationCount)
                        onClicked: button => {
                            if (button === Qt.RightButton)
                                Quickshell.execDetached(["swaync-client", "--toggle-dnd"]);
                            else
                                Quickshell.execDetached(["swaync-client", "--toggle-panel"]);
                        }
                    }
                    BarButton {
                        text: "\uf011"
                        icon: true
                        foreground: "#f7768e"
                        onClicked: Quickshell.execDetached(["bash", Quickshell.env("HOME") + "/.config/quickshell/power-menu.sh"])
                    }
                }
            }
        }
    }
}
