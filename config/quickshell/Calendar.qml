import QtQuick
import QtQuick.Layouts
import Quickshell

PopupWindow {
    id: calendar

    property date viewDate: new Date()

    readonly property var today: new Date()
    readonly property int year: viewDate.getFullYear()
    readonly property int month: viewDate.getMonth()

    readonly property var monthDays: {
        const first = new Date(year, month, 1);
        const startOffset = (first.getDay() + 6) % 7;
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const cells = [];
        for (let i = 0; i < startOffset; i++)
            cells.push(null);
        for (let d = 1; d <= daysInMonth; d++)
            cells.push(d);
        while (cells.length % 7 !== 0)
            cells.push(null);
        return cells;
    }

    function isToday(day) {
        return day !== null && year === today.getFullYear() && month === today.getMonth() && day === today.getDate();
    }

    implicitWidth: 200
    implicitHeight: content.implicitHeight + 20
    color: "transparent"
    visible: false

    anchor.edges: Edges.Top | Edges.Right
    anchor.gravity: Edges.Right | Edges.Bottom
    anchor.margins.left: 6

    Rectangle {
        anchors.fill: parent
        color: "#1a1b26"
        border.color: "#414868"
        radius: 6

        ColumnLayout {
            id: content
            anchors.fill: parent
            anchors.margins: 10
            spacing: 8

            RowLayout {
                Layout.fillWidth: true

                Item {
                    Layout.preferredWidth: 20
                    Layout.preferredHeight: 20

                    Text {
                        anchors.centerIn: parent
                        text: "‹"
                        color: "#c0caf5"
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: viewDate = new Date(year, month - 1, 1)
                    }
                }

                Text {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: Qt.formatDate(viewDate, "MMMM yyyy")
                    color: "#c0caf5"
                    font.bold: true
                    font.pixelSize: 13
                }

                Item {
                    Layout.preferredWidth: 20
                    Layout.preferredHeight: 20

                    Text {
                        anchors.centerIn: parent
                        text: "›"
                        color: "#c0caf5"
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: viewDate = new Date(year, month + 1, 1)
                    }
                }
            }

            GridLayout {
                columns: 7
                columnSpacing: 2
                rowSpacing: 2
                Layout.fillWidth: true

                Repeater {
                    model: ["M", "T", "W", "T", "F", "S", "S"]
                    delegate: Text {
                        Layout.preferredWidth: 24
                        horizontalAlignment: Text.AlignHCenter
                        text: modelData
                        color: "#565f89"
                        font.pixelSize: 11
                    }
                }

                Repeater {
                    model: monthDays
                    delegate: Rectangle {
                        required property var modelData

                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        radius: 4
                        color: isToday(modelData) ? "#3d59a1" : "transparent"

                        Text {
                            anchors.centerIn: parent
                            visible: parent.modelData !== null
                            text: parent.modelData !== null ? parent.modelData : ""
                            color: "#c0caf5"
                            font.pixelSize: 11
                        }
                    }
                }
            }
        }
    }
}
