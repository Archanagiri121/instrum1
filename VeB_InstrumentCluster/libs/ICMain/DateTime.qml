import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {

    anchors.fill: parent
    Rectangle {
        id: dateTimeRect
        anchors.fill: parent
        color: "transparent"

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                timeText.text = Qt.formatTime(new Date(), "hh:mm")
                dateText.text = Qt.formatDate(new Date(), "dd/MM")
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.centerIn: parent

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 0

                Text {
                    id: timeText
                    font.pixelSize: Math.min(dateTimeRect.width, dateTimeRect.height) * 0.4
                    text: Qt.formatTime(new Date(), "hh:mm")
                    color: "white"

                }

                Text {
                    id: dateText
                    Layout.alignment: Qt.AlignVCenter
                    font.pixelSize: Math.min(dateTimeRect.width, dateTimeRect.height) * 0.20
                    Layout.leftMargin: dateTimeRect.width * 0.03
                    Layout.topMargin: dateTimeRect.width* 0.05
                    text: Qt.formatDate(new Date(), "dd/MM")
                    color: "white"

                }
            }
        }
    }

}
