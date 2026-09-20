import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland

ColumnLayout {
    Layout.alignment: Qt.AlignHCenter
    spacing: 6

    readonly property var sortedToplevels: {
        const list = [...Hyprland.toplevels.values];
        list.sort((a, b) => (a.workspace ? a.workspace.id : 0) - (b.workspace ? b.workspace.id : 0));
        return list;
    }

    Repeater {
        model: sortedToplevels

        delegate: ColumnLayout {
            required property HyprlandToplevel modelData
            required property int index

            readonly property var desktopEntry: modelData.wayland ? DesktopEntries.heuristicLookup(modelData.wayland.appId) : null
            readonly property string iconSource: desktopEntry ? Quickshell.iconPath(desktopEntry.icon, "") : ""

            spacing: 6
            Layout.alignment: Qt.AlignHCenter

            Rectangle {
                visible: index > 0 && sortedToplevels[index - 1].workspace !== modelData.workspace
                Layout.preferredWidth: 20
                Layout.preferredHeight: 1
                Layout.alignment: Qt.AlignHCenter
                color: "#414868"
            }

            MouseArea {
                Layout.preferredWidth: 32
                Layout.preferredHeight: 24
                Layout.alignment: Qt.AlignHCenter

                onClicked: Hyprland.dispatch("focuswindow address:0x" + modelData.address)

                Rectangle {
                    anchors.centerIn: parent
                    width: 24
                    height: 24
                    radius: 6
                    color: modelData.activated ? "#3d59a1" : "#292e42"

                    IconImage {
                        visible: iconSource !== ""
                        anchors.centerIn: parent
                        implicitSize: 16
                        source: iconSource
                    }

                    Text {
                        visible: iconSource === ""
                        anchors.centerIn: parent
                        text: modelData.title.slice(0, 2)
                        font.pixelSize: 11
                        color: "#c0caf5"
                        elide: Text.ElideRight
                    }
                }
            }
        }
    }
}
