import QtQuick
import Quickshell

PopupWindow {
    id: tooltip

    property alias text: label.text

    implicitWidth: label.implicitWidth + 16
    implicitHeight: label.implicitHeight + 10
    color: "transparent"
    visible: false

    anchor.edges: Edges.Top | Edges.Right
    anchor.gravity: Edges.Right | Edges.Bottom
    anchor.margins.left: 6

    Rectangle {
        anchors.fill: parent
        color: "#1a1b26"
        border.color: "#414868"
        radius: 4
    }

    Text {
        id: label
        anchors.centerIn: parent
        color: "#c0caf5"
        font.pixelSize: 12
    }
}
