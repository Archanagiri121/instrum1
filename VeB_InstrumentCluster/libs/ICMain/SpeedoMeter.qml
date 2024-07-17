import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import Qt5Compat.GraphicalEffects

Item {
    id: speedoMeterItem
    anchors.fill: parent

    property bool accelerating: homescreenRect.keySpacePressed
    property bool ifSimulatedSpeed: false
    property int speedRangeUpper: 200
    property int speedRange: accelerating ? speedRangeUpper : 0
    property alias currentSpeed: speedSlider.value
    property int carSpeed: mainController.vehicleMetrics.speed
    property int startPtArc: 60
    property int endPtArc: 180 - startPtArc
    property int shapeArcAngleSize: (360 - (endPtArc - startPtArc))
    property int arcCenterX: speedoMeterRect.width / 2
    property int arcCenterY: speedoMeterRect.height / 2
    property int arcRadius: Math.min(speedoMeterRect.width,
                                     speedoMeterRect.height) / 2.3
    property int strokeWidthSize: 30
    property int sweepAngleArc: (carSpeed * (shapeArcAngleSize / speedRangeUpper))
    property int animatTime: 1000

    onCurrentSpeedChanged: {
        if (!ifSimulatedSpeed) {
            mainController.vehicleMetrics.setSpeed(currentSpeed)
        }
    }

    Connections {
        target: mainController.vehicleMetrics
        function onSpeedChanged() {
            if (ifSimulatedSpeed)
                currentSpeed = carSpeed
        }
    }

    Component.onCompleted: {
        speedSeqAnim.start()
    }

    Rectangle {
        id: speedoMeterRect
        width: parent.width
        height: parent.height
        color: "#00000000"
        focus: true

        Canvas {
            id: cnvasGradiantArc
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)

                var gradient = ctx.createLinearGradient(width / 4, 0, width, 0)
                gradient.addColorStop(0.0, "#E9FF63")
                gradient.addColorStop(0.3, "#FF3D00")
                gradient.addColorStop(0.8, "#FF0000")

                ctx.lineWidth = strokeWidthSize
                ctx.strokeStyle = gradient
                ctx.beginPath()

                var centerX = arcCenterX
                var centerY = arcCenterY
                var radius = arcRadius
                var startAngle = (startPtArc * Math.PI) / 180
                var endAngle = (endPtArc * Math.PI) / 180
                ctx.arc(centerX, centerY, radius, endAngle, startAngle, false)
                ctx.stroke()
            }
        }

        Shape {
            id: speedArc
            anchors.fill: parent
            visible: true

            ShapePath {
                strokeColor: "#0A1425"
                strokeWidth: strokeWidthSize + 2
                fillColor: "#00000000"
                capStyle: ShapePath.FlatCap

                PathAngleArc {
                    id: arc
                    centerX: arcCenterX
                    centerY: arcCenterY
                    radiusX: arcRadius
                    radiusY: arcRadius
                    startAngle: startPtArc
                    sweepAngle: sweepAngleArc - shapeArcAngleSize
                }
            }
        }

        Slider {
            id: speedSlider
            visible: false
            from: 0
            value: 0
            to: 200
            anchors.bottom: parent.bottom
            anchors.left: parent.left
        }

        NumberAnimation {
            id: speedUpAnim
            target: speedSlider
            property: "value"
            to: speedRange
            duration: (animatTime * 3)
            running: accelerating
        }

        NumberAnimation {
            id: speedDownAnim
            target: speedSlider
            property: "value"
            to: speedRange
            duration: (animatTime * 2)
            running: !accelerating
        }

        SequentialAnimation {
            id: speedSeqAnim
            running: false
            NumberAnimation {
                target: speedSlider
                property: "value"
                from: 0
                to: speedRangeUpper
                duration: (animatTime * 2)
            }
            NumberAnimation {
                target: speedSlider
                property: "value"
                from: speedRangeUpper
                to: 0
                duration: (animatTime * 2)
            }
        }

        Rectangle {
            id: speedCircle
            width: Math.min(speedoMeterRect.width, speedoMeterRect.height) / 2
            height: width
            radius: width / 2
            anchors {
                horizontalCenter: speedoMeterRect.horizontalCenter
                verticalCenter: speedoMeterRect.verticalCenter
            }
            visible: false
            RadialGradient {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: "#0B2533"
                    }
                    GradientStop {
                        position: 0.6
                        color: "#09111E"
                    }
                }
            }
            antialiasing: true

            Text {
                id: speedText
                font.pixelSize: Math.min(speedoMeterRect.width,
                                         speedoMeterRect.height) * 0.18
                font.family: "Inter"
                font.weight: Font.Normal
                text: mainController.vehicleMetrics.speed.toFixed(
                          0) //speedSlider.value.toFixed(0)
                color: "#FFFFFF"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                    verticalCenterOffset: -10
                }
            }
            Text {
                id: speedUnitText
                anchors.top: speedText.bottom
                text: "KMPH"
                font.pixelSize: Math.min(speedoMeterRect.width,
                                         speedoMeterRect.height) * 0.07
                font.family: "Inter"
                font.weight: Font.Normal
                font.bold: true
                color: "#FFFFFF"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Rectangle {
            id: speedCircleMask
            width: Math.min(speedoMeterRect.width, speedoMeterRect.height) / 2
            height: width
            radius: width / 2
            anchors {
                horizontalCenter: speedoMeterRect.horizontalCenter
                verticalCenter: speedoMeterRect.verticalCenter
            }
            color: "#FFFFFF"
            visible: false
        }

        OpacityMask {
            anchors.fill: speedCircle
            source: speedCircle
            maskSource: speedCircleMask
        }

        Rectangle {
            id: tickMarkRect
            anchors.fill: parent
            color: "#00000000"
            focus: true
            PathView {
                id: pathView
                anchors.fill: parent
                model: 90
                delegate: Rectangle {
                    width: 1
                    height: 10
                    radius: width / 2
                    color: "#FFFFFF"
                    antialiasing: true
                    rotation: ((360) / pathView.model) * index
                }
                path: Path {
                    id: tickMarkArc
                    PathAngleArc {
                        id: tickmarkArc
                        centerX: speedoMeterRect.width / 2
                        centerY: speedoMeterRect.height / 2
                        radiusX: arcRadius / 1.45
                        radiusY: arcRadius / 1.45
                        startAngle: 90
                        sweepAngle: 360
                    }
                }
            }
        }
    }
}
