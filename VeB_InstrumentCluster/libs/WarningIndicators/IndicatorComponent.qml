import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtMultimedia 6.3

Rectangle {
    id: rectIndicator
    anchors.fill: parent
    color: "#00000000"

    property string source: ""
    property int blinkDuration: 120
    property bool isActive: false
    property string soundSource: ""

    Image {
        id: imgIndicator
        source: rectIndicator.source
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
    }

    SequentialAnimation {
        id: blinkAnimation
        running: rectIndicator.isActive && rectIndicator.source != "assets/Image/upperHeadlamp.png" && rectIndicator.source != "assets/Image/dipperHeadlamp.png"
        loops: Animation.Infinite

        PauseAnimation { duration: 500 }

        PropertyAnimation {
            target: rectIndicator
            property: "opacity"
            from: 1.0
            to: 0.0
            duration: rectIndicator.blinkDuration
            easing.type: Easing.InOutQuad
        }

        PauseAnimation { duration: 10 }

        PropertyAnimation {
            target: rectIndicator
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: rectIndicator.blinkDuration
            easing.type: Easing.InOutQuad
        }
    }

    SoundEffect {
        id: blinkSound
        source: soundSource
        loops: SoundEffect.Infinite
    }

    Component.onCompleted: {
        if (rectIndicator.isActive) {
            blinkSound.play();
        } else {
            blinkSound.stop();
        }
    }

    onIsActiveChanged: {
        if (rectIndicator.isActive) {
            blinkSound.play();
        } else {
            blinkSound.stop();
            rectIndicator.opacity = 1.0;
        }
    }
}
