import QtQuick
import QtQuick.Shapes 1.7
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
    id:rangeMeter
    anchors.fill: parent
    property bool keyPressed: homescreenRect.keySpacePressed
    property real centerx:rangeMeterRect.width/2
    property real centery: rangeMeterRect.height/2
    property real radius:Math.min(rangeMeterRect.width,rangeMeterRect.height) / 2
    property real colorval: ((pathViewDrive.model)/200)
    property int speed: driveSlider.value
    property real releaseValue: 0
    property int animatTime: 1000
    property int models: 5
    property real startSliderValue:0
    property real endSliderValue:200
    property real currentRange: mainController.vehicleMetrics.rangeMeter

    Component.onCompleted: {
        driveText.x = pathViewDrive.itemAtIndex(pathViewDrive.model-1).x-(driveText.width+5)
        driveText.y=pathViewDrive.itemAtIndex(pathViewDrive.model-1).y+20
        regenText.x=pathViewRegn.itemAtIndex(pathViewRegn.model-1).x+15
        regenText.y=pathViewRegn.itemAtIndex(pathViewRegn.model-1).y
        driveSeqAnim.start();
        regenSeqAnim.start();
    }

    Rectangle {
        id:rangeMeterRect
        anchors.fill: parent
        height: parent.height
        width: parent.width
        focus: true
        color: "#00000000"
        onWidthChanged: {
            driveText.x=pathViewDrive.itemAtIndex(pathViewDrive.model-1).x-(driveText.width+5)
            driveText.y=pathViewDrive.itemAtIndex(pathViewDrive.model-1).y+20
            regenText.x=pathViewRegn.itemAtIndex(pathViewRegn.model-1).x+15
            regenText.y=pathViewRegn.itemAtIndex(pathViewRegn.model-1).y

        }
        onHeightChanged: {
            driveText.x=pathViewDrive.itemAtIndex(pathViewDrive.model-1).x-(driveText.width+5)
            driveText.y=pathViewDrive.itemAtIndex(pathViewDrive.model-1).y+20
            regenText.x=pathViewRegn.itemAtIndex(pathViewRegn.model-1).x+15
            regenText.y=pathViewRegn.itemAtIndex(pathViewRegn.model-1).y
        }
        PathView {
            id: pathViewDrive
            anchors.fill: parent
            model: models*9
            delegate: Rectangle {
                width: 6
                height:30
                radius: width / 2
                color:   index >= 0 ? (index <= ( (speed *colorval)) ? "red" : "#DD7B7B"):"#DD7B7B"
                antialiasing: true
                rotation:90 + (pathArcDrive.sweepAngle/pathViewDrive.model ) * index

            }
            path: Path {
                PathAngleArc {
                    id:pathArcDrive
                    centerX: centerx
                    centerY: centery
                    radiusX: radius/1.2
                    radiusY: radius/1.2
                    startAngle: 180
                    sweepAngle: 225
                }
            }

        }
        PathView {
            id: pathViewRegn
            anchors.fill: parent
            model: models*4
            delegate: Rectangle {
                width: 6
                height:30
                radius: width / 2
                color: index < (regenSlider.value * (20/200)) ? (!keyPressed ? "green"  : "white") : "white"
                antialiasing: true
                rotation:90 + (pathArcRegn.sweepAngle/pathViewRegn.model ) * index

            }
            path: Path {
                PathAngleArc {
                    id:pathArcRegn
                    centerX: centerx
                    centerY: centery
                    radiusX: radius/1.2
                    radiusY: radius/1.2
                    startAngle: 180
                    sweepAngle: -95
                }
            }

        }

        Rectangle {
            id: rangeCircle
            width: Math.min(rangeMeterRect.width, rangeMeterRect.height) / 2
            height: width
            radius: width/ 2
            anchors {
                horizontalCenter: rangeMeterRect.horizontalCenter
                verticalCenter: rangeMeterRect.verticalCenter
            }
            visible: false
            RadialGradient {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#0B2533" }
                    GradientStop { position: 0.6; color: "#09111E" }
                }
            }
            antialiasing: true
            Text   {
                id: rangeText
                font.pixelSize: parent.width/3.6
                font.family: "Inter"
                font.weight: Font.Bold
                text: currentRange.toFixed(0)//currentRange.toFixed(0)
                color: "#FFFFFF"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
            }
            Text {
                id: rangeLabel
                text: "RANGE"
                font.pixelSize: Math.min(rangeMeterRect.width, rangeMeterRect.height) / 18
                font.family: "Inter"
                font.weight: Font.Normal
                font.bold: true
                color: "#FFFFFF"
                anchors {
                    top: parent.top
                    topMargin: parent.height / 5
                    left: parent.left
                    leftMargin: parent.width / 2.9
                }
            }
            Text {
                id: kmLabel
                text: "KM"
                font.pixelSize: Math.min(rangeMeterRect.width, rangeMeterRect.height) / 14
                font.family: "Inter"
                font.weight: Font.Normal
                font.bold: true
                color: "#FFFFFF"
                anchors {
                    top: parent.top
                    topMargin: parent.height / 2 + 28
                    left: parent.left
                    leftMargin: parent.width / 2.4
                }
            }
        }
        Rectangle {
            id: maskingRectangle
            width: Math.min(rangeMeterRect.width, rangeMeterRect.height) / 2
            height: width
            radius: width/ 2
            anchors {
                horizontalCenter: rangeMeterRect.horizontalCenter
                verticalCenter: rangeMeterRect.verticalCenter
            }
            color: "#FFFFFF"
            visible: false
        }
        OpacityMask {
            anchors.fill: rangeCircle
            source: rangeCircle
            maskSource: maskingRectangle
        }
        Text{
            id: regenText
            text: "REGN"
            color:"#FFFFFF"
            font.family: "Inter"
            font.pixelSize:  Math.min(rangeMeterRect.width, rangeMeterRect.height) / 15
        }
        Text{
            id: driveText
            text: "DRIVE"
            color:"#FFFFFF"
            font.family: "Inter"
            font.pixelSize: Math.min(rangeMeterRect.width, rangeMeterRect.height) / 15
        }

        Slider {
            id: driveSlider
            visible: false
            from: startSliderValue
            value: 0
            to: endSliderValue
            anchors.bottom: parent.bottom
            anchors.left: parent.left
        }
        Slider{
            id: regenSlider
            visible: false
            from: startSliderValue
            value: releaseValue
            to:endSliderValue
        }

        NumberAnimation {
            id:driveUpAnim
            target: driveSlider
            property: "value"
            to:endSliderValue
            duration: (animatTime*3)
            running: keyPressed
        }

        NumberAnimation {
            id:driveDownAnim
            target: driveSlider
            property: "value"
            to:startSliderValue
            duration:(animatTime*2)
            running: !keyPressed
        }

        NumberAnimation {
            id: regenUpAnim
            target: regenSlider
            property: "value"
            from: startSliderValue
            to: releaseValue
            duration: (animatTime*2) * 0.3
            running: !keyPressed
        }
        NumberAnimation {
            id: regenDownAnim
            target: regenSlider
            property: "value"
            from: releaseValue
            to:startSliderValue
            duration: (animatTime*2) * 0.7
            running: !keyPressed
        }
    }
    SequentialAnimation {
        id: driveSeqAnim
        running: false
        NumberAnimation {
            target: driveSlider
            property: "value"
            from: startSliderValue
            to: endSliderValue
            duration: (animatTime*2)
        }
        NumberAnimation {
            target: driveSlider
            property: "value"
            from: endSliderValue
            to: startSliderValue
            duration: (animatTime*2)
        }
    }
    SequentialAnimation {
        id: regenSeqAnim
        running: false
        NumberAnimation {
            target: regenSlider
            property: "value"
            from: startSliderValue
            to: endSliderValue
            duration: (animatTime*2)
        }
        NumberAnimation {
            target:  regenSlider
            property: "value"
            from: endSliderValue
            to: startSliderValue
            duration: (animatTime*2)
        }
    }

}




