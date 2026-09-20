import QtQuick
import QtQuick.Layouts

Item {
    id: clockRoot

    Layout.preferredWidth: 32
    Layout.preferredHeight: clockText.implicitHeight
    Layout.alignment: Qt.AlignHCenter

    Text {
        id: clockText
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#c0caf5"
        font.pixelSize: 13
        font.bold: true
        lineHeight: 1.1
        horizontalAlignment: Text.AlignHCenter
        text: Qt.formatDateTime(new Date(), "yy\nMM\ndd\nhh\nmm")

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clockText.text = Qt.formatDateTime(new Date(), "yy\nMM\ndd\nhh\nmm")
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            if (calendar.visible)
                return;
            clockTooltip.text = Qt.formatDate(new Date(), "dddd, MMMM d yyyy");
            clockTooltip.anchor.item = clockRoot;
            clockTooltip.visible = true;
        }
        onExited: clockTooltip.visible = false

        onClicked: {
            clockTooltip.visible = false;
            if (!calendar.visible)
                calendar.viewDate = new Date();
            calendar.anchor.item = clockRoot;
            calendar.visible = !calendar.visible;
        }
    }

    Tooltip {
        id: clockTooltip
    }

    Calendar {
        id: calendar
    }
}
