import QtQuick
import QtQuick3D
import QtQuick3D.Particles3D
import QtQuick.Controls
import ICMain

Item {
    anchors.bottom:parent.bottom
    anchors.bottomMargin: 40
    property int liveSpeed: speedoMeterComponent.currentSpeed

    Image{
        id: firstCarImg
        source: "Image/MainCarImg.png"
        sourceSize.height:  parent.height/2
        sourceSize.width: parent.width / 1.5
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        z:1
    }

    Image{
        id: secondCarImg
        source: "Image/SecCarImg.png"
        sourceSize.height: parent.height/8
        sourceSize.width:parent.width/8
        anchors.bottom: firstCarImg.top
        anchors.bottomMargin:  parent.height/4.9
        anchors.horizontalCenter: parent.horizontalCenter
        z:1
    }
    Image{
        id: fogImg
        source: "Image/FogOverlay.png"
        sourceSize.height: parent.height/1.5
        sourceSize.width: parent.width/1.5
        opacity: 1
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        z:1
    }

    View3D {
        id: scene3d
        anchors.fill: parent
        environment: SceneEnvironment {
            clearColor: "#00000000"
            backgroundMode: SceneEnvironment.Color
            antialiasingMode: SceneEnvironment.SSAA
        }

        // Camera with a third perspective view
        PerspectiveCamera {
            position: Qt.vector3d(0, 180, 800)
            eulerRotation: Qt.vector3d(-30, 0, 0)
            clipFar: 1000
        }

        // PointLight for basic lighting
        PointLight {
            id: pointLight
            position: Qt.vector3d(200, 200, 400)
            brightness: 50
            ambientColor: Qt.rgba(0.5, 0.3, 0.1, 1.0)
            SequentialAnimation {
                loops: Animation.Infinite
                running: true
                NumberAnimation {
                    target: pointLight
                    property: "brightness"
                    to: 400
                    duration: 2000
                    easing.type: Easing.OutElastic
                }
                NumberAnimation {
                    target: pointLight
                    property: "brightness"
                    to: 50
                    duration: 6000
                    easing.type: Easing.InOutQuad
                }
            }
        }

        // Road model
        Model {
            id: roadModel
            source: "#Cube"
            scale: Qt.vector3d(2.1, 0.1, 500)
            position: Qt.vector3d(0, 0, -24000)
            opacity: 0.9

            materials: PrincipledMaterial {
                baseColorMap: Texture {
                    source: "Image/TransparentRoad.png"
                }
            }

            // to move the road infinitely
            SequentialAnimation {
                loops: Animation.Infinite
                running: liveSpeed == 0 ? false : true

                NumberAnimation {
                    id: numAnim
                    target: roadModel
                    property: "position.z"
                    from: -20000
                    to: 0
                    duration: 50000
                }

                // reset to starting position
                PropertyAction {
                    target: roadModel
                    property: "position.z"
                    value: 0
                }
            }

        }

    }

}


