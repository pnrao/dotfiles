//@ pragma UseQApplication
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Services.SystemTray

PanelWindow {
    id: bar

    anchors {
        top: true
        bottom: true
        left: true
    }

    implicitWidth: 40
    exclusiveZone: 40
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Top

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(26 / 255, 27 / 255, 38 / 255, 0.9)

        Rectangle {
            anchors.right: parent.right
            width: 2
            height: parent.height
            color: "#414868"
        }
    }

    ColumnLayout {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 8
        spacing: 12

        MouseArea {
            Layout.preferredWidth: 32
            Layout.preferredHeight: 28
            Layout.alignment: Qt.AlignHCenter

            onClicked: Quickshell.execDetached(["wofi", "-I", "--show", "drun,run", "--style", "/home/pnrao/.config/wofi/style.css"])

            IconImage {
                anchors.centerIn: parent
                implicitSize: 22
                source: "file:///usr/share/icons/Papirus/48x48/apps/ubuntu-logo-icon.svg"
            }
        }

        Workspaces {}

        Windows {}
    }

    ColumnLayout {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 8
        spacing: 8

        Clock {}

        Repeater {
            model: SystemTray.items

            delegate: MouseArea {
                id: trayItem
                required property SystemTrayItem modelData

                Layout.preferredWidth: 32
                Layout.preferredHeight: 24
                Layout.alignment: Qt.AlignHCenter
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                hoverEnabled: true

                onEntered: {
                    trayTooltip.text = modelData.tooltipTitle;
                    trayTooltip.anchor.item = trayItem;
                    trayTooltip.visible = trayTooltip.text.length > 0;
                }
                onExited: trayTooltip.visible = false

                IconImage {
                    anchors.centerIn: parent
                    width: 20
                    height: 20
                    source: modelData.icon
                }

                onClicked: mouse => {
                    const pos = trayItem.mapToItem(null, mouse.x, mouse.y);
                    // pasystray's appindicator item has no Activate and ignores SecondaryActivate
                    const isPasystray = modelData.id === "pasystray";
                    if (mouse.button === Qt.MiddleButton) {
                        if (isPasystray)
                            Quickshell.execDetached(["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]);
                        else
                            modelData.secondaryActivate();
                    } else if (mouse.button === Qt.LeftButton && isPasystray) {
                        volumePopup.anchor.item = trayItem;
                        volumePopup.visible = !volumePopup.visible;
                    } else if (mouse.button === Qt.LeftButton && !modelData.onlyMenu) {
                        modelData.activate();
                    } else if (modelData.hasMenu) {
                        modelData.display(bar, pos.x, pos.y);
                    }
                }
                onWheel: wheel => modelData.scroll(wheel.angleDelta.y / 120, false)
            }
        }

        MouseArea {
            Layout.preferredWidth: 32
            Layout.preferredHeight: 24
            Layout.alignment: Qt.AlignHCenter

            onClicked: Quickshell.execDetached(["/home/pnrao/.config/hypr/power_menu.sh"])

            Text {
                anchors.centerIn: parent
                text: ""
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 16
                color: "#c0caf5"
            }
        }
    }

    Tooltip {
        id: trayTooltip
    }

    VolumePopup {
        id: volumePopup
    }
}
