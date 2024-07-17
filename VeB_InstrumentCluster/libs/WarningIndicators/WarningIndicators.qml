import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia 6.3

Item{
    id: itmWarningIndicators
    anchors.fill: parent
    anchors.centerIn: parent

    Rectangle{
        id: rectWarningIndicators
        anchors.fill: parent
        color: "#00000000"
        clip: true

        RowLayout {
            spacing: 20
            anchors.centerIn: parent
            width: parent.width * 0.8
            height: parent.height * 0.6

            Rectangle {
                id: rectLeftIndicator
                Layout.fillWidth: true
                Layout.fillHeight: true
                width: 60
                height: width
                color: "#00000000"

                IndicatorComponent {
                    id: leftIndicator
                    source: mainController.warningIndicatorController.leftIndicatorIsActivated ? "assets/Image/leftOnIndicator.png" : "assets/Image/leftOffIndicator.png"
                    soundSource: "assets/Music/turnIndicator_Sound1.wav"
                    isActive : mainController.warningIndicatorController.leftIndicatorIsActivated
                }
            }

            Rectangle {
                id: rectHeadLightIndicator
                Layout.fillWidth: true
                Layout.fillHeight: true
                width: 60
                height: width
                color: "#00000000"

                IndicatorComponent {
                    id: headlight
                    isActive: mainController.warningIndicatorController.headlightIndicatorIsActivated
                    source : isActive ? mainController.warningIndicatorController.headlightState === 0 ? "assets/Image/upperHeadlamp.png" : "assets/Image/dipperHeadlamp.png" : "assets/Image/defaultHeadlamp.png"
                }
            }

            Rectangle {
                id: rectDoorIndicator
                Layout.fillWidth: true
                Layout.fillHeight: true
                width: 60
                height: width
                color: "#00000000"

                IndicatorComponent {
                    id: doorIndicator
                    source: mainController.warningIndicatorController.doorIndicatorIsActivated ? "assets/Image/doorAjar.png" : "assets/Image/deafultDoorAjar.png"
                    isActive: mainController.warningIndicatorController.doorIndicatorIsActivated
                }
            }

            Rectangle {
                id: rectGearStateIndicator
                Layout.fillWidth: true
                Layout.fillHeight: true
                width: 80
                height: width
                color: "#00000000"

                IndicatorComponent {

                    GearStateIndicator{
                        id: rectGearIndicator
                    }
                }
            }

            Rectangle {
                id: rectHandbrakeIndicator
                Layout.fillWidth: true
                Layout.fillHeight: true
                width: 60
                height: width
                color: "#00000000"

                IndicatorComponent {
                    id: handbrakeIndicator
                    source: mainController.warningIndicatorController.handbrakeIndicatorIsActivated ? "assets/Image/handbrake.png" : "assets/Image/defaultHandbrake.png"
                    isActive: mainController.warningIndicatorController.handbrakeIndicatorIsActivated
                }
            }

            Rectangle {
                id: rectSeatbeltIndicator
                Layout.fillWidth: true
                Layout.fillHeight: true
                width: 60
                height: width
                color: "#00000000"

                IndicatorComponent {
                    id: seatbeltIndicator
                    source: mainController.warningIndicatorController.seatbeltIndicatorIsActivated ? "assets/Image/seatbelt.png" : "assets/Image/defaultSeatbelt.png"
                    isActive: mainController.warningIndicatorController.seatbeltIndicatorIsActivated
                    blinkDuration: 250
                    soundSource: "assets/Music/Seatbelt_Warning_Sound1.wav"
                }
            }

            Rectangle {
                id: rectRightIndicator
                Layout.fillWidth: true
                Layout.fillHeight: true
                width: 60
                height: width
                color: "#00000000"

                IndicatorComponent {
                    id: rightIndicator
                    source: mainController.warningIndicatorController.rightIndicatorIsActivated  ? "assets/Image/rightOnIndicator.png" : "assets/Image/rightOffIndicator.png"
                    soundSource: "assets/Music/turnIndicator_Sound1.wav"
                    isActive : mainController.warningIndicatorController.rightIndicatorIsActivated
                }
            }
        }
    }
    Image {
        id: imgUpperCurve
        source: "assets/Image/imgUpperCurve.png"
        sourceSize.width: Math.min(itmWarningIndicators.width * 1.8, Math.max(itmWarningIndicators.width * 1.3, parent.width))
        sourceSize.height: width / sourceSize.aspectRatio
        smooth: true
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: itmWarningIndicators.bottom
            topMargin: -100
        }
    }
}
