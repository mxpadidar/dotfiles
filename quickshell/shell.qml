import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower

ShellRoot {
    id: root
    readonly property int barHeight: 30
    property bool idlePaused: false
    property int notificationCount: 0
    property bool dnd: false
    Process {
        id: notifications
        command: ["swaync-client", "--skip-wait", "--subscribe-waybar"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                try {
                    const state = JSON.parse(data);
                    root.notificationCount = Number(state.text) || 0;
                    root.dnd = String(state.alt).indexOf("dnd") >= 0;
                } catch (error) {}
            }
        }
        onExited: { root.notificationCount = 0; root.dnd = false; }
    }
    Timer {
        interval: 5000
        repeat: true
        running: true
        onTriggered: if (!notifications.running) notifications.running = true
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
            IdleInhibitor { window: bar; enabled: root.idlePaused }
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
                Rectangle {
                    id: workspaceMarker
                    readonly property var current: Hyprland.workspaces.values.find(w => w.active && w.monitor && w.monitor.name === bar.screen.name)
                    readonly property var ids: workspaceRepeater.model.map(w => w.id)
                    readonly property int selected: current ? ids.indexOf(current.id) : -1
                    visible: selected >= 0
                    x: Math.max(0, selected) * 30
                    y: 3
                    width: 28
                    height: 24
                    radius: 5
                    color: "#bb9af7"
                    Behavior on x { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }
                }
                Row {
                    id: leftGroup
                    spacing: 2
                    move: Transition { NumberAnimation { properties: "x"; duration: 180; easing.type: Easing.OutCubic } }
                    add: Transition { NumberAnimation { properties: "opacity"; from: 0; to: 1; duration: 120 } }
                    Repeater {
                        id: workspaceRepeater
                        model: Hyprland.workspaces.values.filter(w => w.id > 0 && (w.active || w.toplevels.values.length > 0)).sort((a, b) => a.id - b.id)
                        BarButton {
                            required property var modelData
                            readonly property var workspace: modelData
                            text: String(workspace.id)
                            width: 28
                            active: false
                            foreground: workspaceMarker.current === workspace ? "#1a1b26" : workspace.urgent ? "#f7768e" : "#a9b1d6"
                            onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + workspace.id + " })")
                        }
                    }

                }
            }
            Text {
                id: clockLabel
                anchors.centerIn: parent
                text: Qt.formatDateTime(clock.date, "HH:mm | ddd dd MMM")
                font {
                    family: "Hasklug Nerd Font"
                    pixelSize: 13
                    bold: true
                }
                color: "#c0caf5"
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
                        width: 76
                        tooltip: UPower.onBattery ? "Running on battery" : "Connected to power"
                        glyph: UPower.onBattery ? "\uf240" : "\uf0e7"
                        text: Math.round(UPower.displayDevice.percentage * 100) + "%"
                        foreground: UPower.onBattery && UPower.displayDevice.percentage <= 10 ? "#f7768e" : UPower.onBattery && UPower.displayDevice.percentage <= 20 ? "#e0af68" : "#a9b1d6"
                    }
                    WifiButton {}
                    BarButton {
                        width: 76
                        tooltip: "Click: mixer · Right-click: mute · Scroll: volume"
                        text: !root.sink || !root.sink.audio ? "Vol ?" : root.sink.audio.muted ? "Muted" : "" + Math.round(root.sink.audio.volume * 100) + "%"
                        glyph: root.sink && root.sink.audio && root.sink.audio.muted ? "\udb81\udd81" : "\uf028"
                        foreground: "#a9b1d6"
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
                        glyph: root.dnd ? "\uf1f6" : "\uf0f3"
                        text: root.notificationCount > 0 ? String(root.notificationCount) : ""
                        tooltip: root.dnd ? "Do not disturb is on" : "Notifications"
                        foreground: root.dnd ? "#bb9af7" : "#a9b1d6"
                        onClicked: button => {
                            if (button === Qt.RightButton)
                                Quickshell.execDetached(["swaync-client", "--toggle-dnd"]);
                            else
                                Quickshell.execDetached(["swaync-client", "--toggle-panel"]);
                        }
                    }
                    BarButton {
                        glyph: "\uf108"
                        active: root.idlePaused
                        tooltip: root.idlePaused ? "Idle paused — click to resume" : "Pause automatic idle actions"
                        foreground: root.idlePaused ? "#bb9af7" : "#a9b1d6"
                        onClicked: root.idlePaused = !root.idlePaused
                    }
                    BarButton {
                        text: "\uf011"
                        icon: true
                        foreground: "#a9b1d6"
                        tooltip: "Power menu"
                        onClicked: Quickshell.execDetached(["bash", Quickshell.env("HOME") + "/.config/quickshell/power-menu.sh"])
                    }
                }
            }
        }
    }
}
