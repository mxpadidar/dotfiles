import QtQuick

Rectangle {
    id: root
    property string tooltip: ""
    BarTooltip {
        target: root
        hovered: mouse.containsMouse
        text: root.tooltip
    }
    Behavior on color { ColorAnimation { duration: 120 } }
    scale: mouse.pressed ? 0.96 : 1
    Behavior on scale { NumberAnimation { duration: 120 } }
    radius: 5
    property alias text: label.text
    property bool active: false
    property bool interactive: true
    property bool icon: false
    property string glyph: ""
    property color foreground: "#a9b1d6"
    signal clicked(var button)
    signal scrolled(real delta)
    implicitWidth: Math.max(24, buttonContent.implicitWidth + 12)
    implicitHeight: 30
    color: mouse.containsMouse && interactive ? "#24283b" : "transparent"
    activeFocusOnTab: interactive
    border.width: activeFocus ? 1 : 0
    border.color: "#bb9af7"
    Keys.onReturnPressed: clicked(Qt.LeftButton)
    Keys.onSpacePressed: clicked(Qt.LeftButton)
    Row {
        id: buttonContent
        anchors.centerIn: parent
        spacing: root.glyph ? 5 : 0
        Text {
            visible: root.glyph !== ""
            text: root.glyph
            anchors.verticalCenter: parent.verticalCenter
            color: root.foreground
            font {
                family: "Hasklug Nerd Font"
                pixelSize: 16
            }
        }
        Text {
            id: label
            anchors.verticalCenter: parent.verticalCenter
            color: root.foreground
            font.family: "Hasklug Nerd Font"
            font.pixelSize: root.icon ? 16 : 13
        }
    }
    Rectangle {
        visible: root.active
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        width: parent.width - 8
        height: 2
        color: "#bb9af7"
    }
    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: root.interactive ? Qt.PointingHandCursor : Qt.ArrowCursor
        acceptedButtons: root.interactive ? Qt.LeftButton | Qt.RightButton : Qt.NoButton
        onClicked: event => root.clicked(event.button)
        onWheel: event => {
            if (root.interactive) root.scrolled(event.angleDelta.y);
            else event.accepted = false;
        }
    }
}
