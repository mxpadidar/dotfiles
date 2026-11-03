import QtQuick
import Quickshell

PopupWindow {
    id: root
    required property Item target
    property bool hovered: false
    property string text: ""
    onHoveredChanged: delay.elapsed = false

    anchor.item: target
    anchor.rect.x: target.width / 2
    anchor.rect.y: target.height + 6
    anchor.edges: Edges.Bottom
    anchor.gravity: Edges.Bottom
    anchor.adjustment: PopupAdjustment.Slide
    visible: hovered && delay.elapsed && text.length > 0
    color: "transparent"
    implicitWidth: Math.ceil(Math.min(label.implicitWidth, 400) + 20)
    implicitHeight: Math.ceil(label.implicitHeight + 16)

    Timer {
        id: delay
        property bool elapsed: false
        interval: 500
        running: root.hovered && root.text.length > 0
        onTriggered: elapsed = true
    }

    Rectangle {
        anchors.fill: parent
        color: "#1a1b26"
        border.color: "#bb9af7"
        radius: 5
        Text {
            id: label
            x: 10
            y: 8
            width: root.width - 20
            text: root.text
            textFormat: Text.PlainText
            wrapMode: Text.Wrap
            color: "#c0caf5"
            font.family: "Hasklug Nerd Font"
            font.pixelSize: 12
        }
    }
}
