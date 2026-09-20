import QtQuick
import QtQuick.Layouts

Text {
    id: clockText

    Layout.preferredWidth: 32
    Layout.alignment: Qt.AlignHCenter
    color: "#c0caf5"
    font.pixelSize: 13
    font.bold: true
    horizontalAlignment: Text.AlignHCenter
    text: Qt.formatDateTime(new Date(), "hh\nmm")

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clockText.text = Qt.formatDateTime(new Date(), "hh\nmm")
    }
}
