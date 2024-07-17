import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: regenComponent
    anchors.fill: parent

    property int batteryLevel: 100
    property int currentLevel: mainController.vehicleMetrics.regenLevel

    onCurrentLevelChanged: {
        mainController.vehicleMetrics.setRegenLevel(currentLevel)
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        clip: true
        focus: true

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                id: imgRect
                Layout.preferredWidth: regenComponent.width / 2.5
                Layout.preferredHeight: regenComponent.height
                color: "transparent"
                Image {
                    id: indicatorImage
                    source: "assets/images/regenrativeBraking.png"
                    anchors{
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                    }

                    anchors.leftMargin: 40
                    sourceSize.width: parent.width * 0.8
                    sourceSize.height: parent.height * 0.8
                }
            }

            Rectangle {
                id: containerRect
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
                PathView {
                    id: pathView
                    anchors.fill: parent
                    anchors.centerIn: parent
                    model: ListModel {
                        ListElement { name: "R1" }
                        ListElement { name: "R2" }
                        ListElement { name: "R3" }
                    }
                    delegate: Rectangle {
                        width: containerRect.width * 0.22
                        height: containerRect.height * 0.12
                        radius: width / 2
                        property bool isActive: index < currentLevel
                        color: isActive ? "#12FCC8" : "#D0FCF2"

                        Behavior on color {
                            ColorAnimation {
                                duration: 500
                            }
                        }

                        Text {
                            id: regenText
                            anchors.bottom: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: model.name
                            font.bold: true
                            visible: isActive && (index === currentLevel - 1)
                            color: "white"
                            opacity: visible ? 1.0 : 0.0

                            Behavior on opacity {
                                NumberAnimation {
                                    duration: 500
                                }
                            }
                           font.pixelSize: Math.min(regenComponent.width, regenComponent.height) * 0.18
                        }
                    }
                    path: Path {
                        startX: containerRect.width * 0.25
                        startY: containerRect.height * 0.75
                        PathLine {
                            x: containerRect.width * 0.65
                            y: containerRect.height * 0.45
                        }
                        PathLine {
                            x: containerRect.width * 0.8
                            y: containerRect.height * 0.25
                        }
                    }
                }
            }
        }
    }
    function cycleLevels() {
        currentLevel = (currentLevel % 3) + 1;
    }
}
