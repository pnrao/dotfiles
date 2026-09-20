import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

ColumnLayout {
    Layout.alignment: Qt.AlignHCenter
    spacing: 6

    Repeater {
        model: Hyprland.workspaces

        delegate: MouseArea {
            required property HyprlandWorkspace modelData

            Layout.preferredWidth: 32
            Layout.preferredHeight: 24
            Layout.alignment: Qt.AlignHCenter

            onClicked: modelData.activate()

            Rectangle {
                anchors.centerIn: parent
                width: 24
                height: 24
                radius: 6
                color: modelData.focused ? "#3d59a1" : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: modelData.id
                    font.pixelSize: 13
                    color: modelData.focused ? "#c0caf5" : "#565f89"
                }
            }
        }
    }
}
