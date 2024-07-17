import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Shapes 1.15

Item {
    id: batteryMeter
    anchors.fill: parent
    property real battery: mainController.vehicleMetrics.batteryPercent

    Rectangle {
        id: batteryMeterContainer
        anchors.fill: parent
        color: "transparent"
        anchors.centerIn: parent

        RowLayout {
            id: batteryLayout
            anchors.fill: parent
            spacing: 0

            Rectangle {
                id: carImgRect
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.3
                Layout.leftMargin: parent.width * 0.1
                color: "transparent"

                Image {
                    id: carImg
                    source: "assets/images/batteryCar.png"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    sourceSize.width: parent.width * 0.8
                    sourceSize.height: parent.height * 0.8
                }
            }

            Rectangle {
                id: batteryRect
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.3
                color: "transparent"

                Rectangle {
                    id: outerRectangle
                    width: parent.width * 0.7
                    height: parent.height * 0.4
                    radius: 8
                    color: "#232323"
                    anchors.centerIn: parent
                    clip: true

                    property int padding: 2

                    Rectangle {
                        id: batteryLiquid
                        width: Math.max((battery / 100) * (outerRectangle.width - 2 * outerRectangle.padding), (outerRectangle.width - 2 * outerRectangle.padding) * 0.07)
                        height: outerRectangle.height - 2 * outerRectangle.padding
                        radius: 7

                        anchors {
                            left: parent.left
                            leftMargin: outerRectangle.padding
                            verticalCenter: parent.verticalCenter
                        }
                        color: battery <= 20 ? "red" : battery >= 60 ? "#06D001" : "#FFC700"

                        Behavior on width {
                            NumberAnimation {
                                duration: 300
                            }
                        }
                        Behavior on color {
                            ColorAnimation {
                                duration: 300
                            }
                        }
                        SequentialAnimation on color {
                            id: lowBatteryAnimation
                            loops: Animation.Infinite
                            running: battery <= 20
                            ColorAnimation {
                                from: "red"
                                to: "transparent"
                                duration: 500
                            }
                            ColorAnimation {
                                from: "transparent"
                                to: "red"
                                duration: 500
                            }
                        }
                    }
                }

                Rectangle {
                    id: batteryCap
                    width: outerRectangle.height * 0.08
                    height: outerRectangle.height * 0.5
                    radius: height / 2
                    color: "#232323"
                    anchors {
                        left: outerRectangle.right
                        verticalCenter: outerRectangle.verticalCenter
                        leftMargin: 4
                    }
                }
            }

            Rectangle {
                id: batteryPercentageRect
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.32
                color: "transparent"

                Text {
                    id: batteryPercentageText
                    text: battery.toFixed(0) + "%"
                    Layout.fillWidth: true
                    color: "#FFFFFF"
                    font.bold: true
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: Math.min(outerRectangle.width, outerRectangle.height) * 0.5
                }
            }
        }
    }
}
