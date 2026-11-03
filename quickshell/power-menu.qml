import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

ShellRoot {
    id: root
    property int selected: 0
    readonly property var options: ["Lock", "Suspend", "Logout", "Reboot", "Shutdown"]
    readonly property var focusedScreen: Quickshell.screens.find(s => Hyprland.focusedMonitor && s.name === Hyprland.focusedMonitor.name) || Quickshell.screens[0]

    function choose(index) {
        run(options[index]);
    }
    function run(action) {
        Quickshell.execDetached(["bash", Qt.resolvedUrl("power-menu.sh").toString().replace(/^file:\/\//, ""), "--action", action]);
        Qt.quit();
    }

    PanelWindow {
        screen: root.focusedScreen
        anchors { top: true; bottom: true; left: true; right: true }
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
        color: "transparent"

        MouseArea { anchors.fill: parent; onClicked: Qt.quit() }
        Item {
            anchors.fill: parent
            focus: true
            Keys.onPressed: event => {
                if (event.key === Qt.Key_J || event.key === Qt.Key_Down)
                    root.selected = (root.selected + 1) % root.options.length;
                else if (event.key === Qt.Key_K || event.key === Qt.Key_Up)
                    root.selected = (root.selected + root.options.length - 1) % root.options.length;
                else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                    root.choose(root.selected);
                else if (event.key === Qt.Key_Escape)
                    Qt.quit();
                event.accepted = true;
            }
            Rectangle {
                anchors.centerIn: parent
                width: 220
                height: content.implicitHeight + 12
                radius: 5
                color: "#1a1b26"
                border.color: "#bb9af7"
                // Consume clicks in menu padding rather than dismissing it.
                MouseArea { anchors.fill: parent }
                Column {
                    id: content
                    x: 6; y: 6
                    width: parent.width - 12
                    spacing: 2
                    Repeater {
                        model: root.options
                        Rectangle {
                            required property int index
                            required property string modelData
                            width: content.width
                            height: 28
                            radius: 5
                            color: root.selected === index ? "#bb9af7" : "transparent"
                            Behavior on color { ColorAnimation { duration: 100 } }
                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                color: root.selected === index ? "#1a1b26" : "#c0caf5"
                                font.family: "Hasklug Nerd Font"
                                font.pixelSize: 13
                            }
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onEntered: root.selected = parent.index
                                onClicked: root.choose(parent.index)
                            }
                        }
                    }
                }
            }
        }
    }
}
