import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 1.1
import Qt5Compat.GraphicalEffects
import CarModel
import Navigation
import WarningIndicators

Rectangle {
    id: homescreenRect
    radius: 100
    anchors.fill: parent

    property bool keySpacePressed: mainController.vehicleMetrics.spacePressed
    property bool updateSpeed: false
    property int upperLowerHeight: 88
    property int middleHeight: 394
    property int upperLowerWidth: 232
    property int middlewidth: 318
    property int marginsVal: 39

    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop {
            color: "#242A2F"
            position: 0.0
        }
        GradientStop {
            color: "#2A393E"
            position: 0.30
        }
        GradientStop {
            color: "#325F62"
            position: 0.45
        }
        GradientStop {
            color: "#325F62"
            position: 0.55
        }
        GradientStop {
            color: "#2A393E"
            position: 0.70
        }
        GradientStop {
            color: "#242A2F"
            position: 1.00
        }
    }

    ColumnLayout {
        id: mainColumn
        anchors {
            fill: parent
            leftMargin: marginsVal
            rightMargin: marginsVal
        }

        //upper layouts
        RowLayout {
            id: upperRow
            Layout.preferredHeight: upperLowerHeight
            Layout.fillWidth: true

            Rectangle {
                id: dateTimeIndicator
                color: "#00000000"
                Layout.preferredWidth: upperLowerWidth
                Layout.fillWidth: true
                Layout.fillHeight: true

                DateTime {}

                BoundaryBox {}
            }

            Rectangle {
                id: warningIndicators
                color: "#00000000"
                Layout.preferredWidth: 1106
                Layout.fillWidth: true
                Layout.fillHeight: true

                WarningIndicators {
                    id: warningIndicatorsComponent
                }

                BoundaryBox {}
            }

            Rectangle {
                id: whetherIndicator
                color: "#00000000"
                Layout.preferredWidth: upperLowerWidth
                Layout.fillWidth: true
                Layout.fillHeight: true

                WeatherPage {
                    id: weatherModule
                }

                BoundaryBox {}
            }
        }
        //middle layout
        RowLayout {
            id: middleRow

            Layout.preferredHeight: middleHeight
            Layout.fillWidth: true

            Rectangle {
                id: speedometerIndicator
                color: "#00000000"
                Layout.preferredWidth: middlewidth
                Layout.fillWidth: true
                Layout.fillHeight: true

                SpeedoMeter {
                    id: speedoMeterComponent
                }

                BoundaryBox {}
            }

            Rectangle {
                id: mainMiddleScreen
                color: "#00000000"
                Layout.preferredWidth: 629
                Layout.fillWidth: true
                Layout.fillHeight: true







                MenuSection{
                    id:menuSection

                }

                BoundaryBox {}

            }

            Rectangle {
                id: rangeIndicator
                color: "#00000000"
                Layout.preferredWidth: middlewidth
                Layout.fillWidth: true
                Layout.fillHeight: true

                RangeMeter {
                    id: rangeMeterComponent
                }

                BoundaryBox {}
            }
        }
        //lower layout
        RowLayout {
            id: lowerRow

            Layout.preferredHeight: upperLowerHeight
            Layout.fillWidth: true

            Rectangle {
                id: batteryIndicator
                color: "#00000000"
                Layout.preferredWidth: upperLowerWidth
                Layout.fillWidth: true
                Layout.fillHeight: true

                BatteryMeter {
                    id: batteryMeterComponent
                }

                BoundaryBox {}
            }

            Rectangle {
                id: odometerIndicator
                color: "#00000000"
                Layout.preferredWidth: 500
                Layout.fillWidth: true
                Layout.fillHeight: true
                Odometer {
                    id: componentOdometer
                }

                BoundaryBox {}
            }

            Rectangle {
                id: regenIndicator
                color: "#00000000"
                Layout.preferredWidth: upperLowerWidth
                Layout.fillWidth: true
                Layout.fillHeight: true

                RegenMeter {
                    id: regenMeterComponent
                }

                BoundaryBox {}
            }
        }
    }
}
