import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire

PopupWindow {
    id: popup

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property bool muted: sink?.audio?.muted ?? false

    function setFromY(y) {
        if (!sink?.audio)
            return;
        sink.audio.volume = Math.max(0, Math.min(1, 1 - (y - track.y) / track.height));
    }

    implicitWidth: 44
    implicitHeight: 180
    color: "transparent"
    visible: false

    anchor.edges: Edges.Top | Edges.Right
    anchor.gravity: Edges.Right | Edges.Bottom
    anchor.margins.left: 6

    PwObjectTracker {
        objects: [popup.sink]
    }

    // Activating in the same tick as visible leaves the grab inactive, so defer it
    onVisibleChanged: {
        if (visible)
            Qt.callLater(() => grab.active = popup.visible);
        else
            grab.active = false;
    }

    HyprlandFocusGrab {
        id: grab
        windows: [popup]
        onCleared: popup.visible = false
    }

    Rectangle {
        anchors.fill: parent
        color: "#1a1b26"
        border.color: "#414868"
        radius: 6

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 6

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: popup.muted ? "mute" : Math.round(popup.volume * 100)
                color: popup.muted ? "#565f89" : "#c0caf5"
                font.pixelSize: 11
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Rectangle {
                    id: track
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: 6
                    radius: 3
                    color: "#414868"

                    Rectangle {
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: parent.height * popup.volume
                        radius: 3
                        color: popup.muted ? "#565f89" : "#7aa2f7"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: mouse => popup.setFromY(mouse.y)
                    onPositionChanged: mouse => popup.setFromY(mouse.y)
                    onWheel: wheel => {
                        if (popup.sink?.audio)
                            popup.sink.audio.volume = Math.max(0, Math.min(1, popup.volume + 0.05 * Math.sign(wheel.angleDelta.y)));
                    }
                }
            }
        }
    }
}
