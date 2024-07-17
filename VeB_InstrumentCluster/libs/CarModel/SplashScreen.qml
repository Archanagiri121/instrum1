import QtQuick
import QtQuick3D
import QtQuick3D.Particles3D
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item
{
    anchors.fill: parent
    Rectangle
    {
        id: splashScreen
        width: parent.width
        height: parent.height
        visible: false
        clip: true

        View3D {
            anchors.fill: parent
            environment: SceneEnvironment
            {
                clearColor: "#000000"
                backgroundMode: SceneEnvironment.Color
            }

            PerspectiveCamera
            {
                position: Qt.vector3d(0, 0, 600)
                clipFar: 2000
            }

            PointLight
            {
                id: pointLight
                position: Qt.vector3d(0, 0, 400)
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

            Model {
                id: modelCube
                source: "#Cube"
                position: Qt.vector3d(0, 0, 0)
                scale: Qt.vector3d(1, 1, 1)
                eulerRotation: Qt.vector3d(20, 0, -20)

                SequentialAnimation {
                    running: true
                    loops: Animation.Infinite
                    ParallelAnimation
                    {
                        NumberAnimation
                        {
                            target: modelCube
                            property: "scale.x"
                            from: 1
                            to: 2
                            duration: 1000
                        }
                        NumberAnimation
                        {
                            target: modelCube
                            property: "scale.y"
                            from: 1
                            to: 2
                            duration: 1000
                        }
                        NumberAnimation
                        {
                            target: modelCube
                            property: "scale.z"
                            from: 1
                            to: 2
                            duration: 1000
                        }

                        NumberAnimation
                        {
                            target: modelCube
                            property: "eulerRotation.y"
                            from: 0
                            to: 180
                            duration: 3000
                        }
                    }


                    ParallelAnimation
                    {
                        NumberAnimation
                        {
                            target: modelCube
                            property: "scale.x"
                            from: 3
                            to: 0
                            duration: 2000
                        }
                        NumberAnimation
                        {
                            target: modelCube
                            property: "scale.y"
                            from: 3
                            to: 0
                            duration: 2000
                        }
                        NumberAnimation
                        {
                            target: modelCube
                            property: "scale.z"
                            from: 3
                            to: 0
                            duration: 2000
                        }
                    }
                }
                materials: PrincipledMaterial
                {
                    baseColorMap: Texture
                    {
                        source: "Image/verolt.png"
                    }
                }
            }

            ParticleSystem3D
            {
                id: psystem
                startTime: 1000
                SpriteParticle3D {
                    id: spriteParticle
                    sprite: Texture {
                        source: "Image/Emitter.png"
                    }
                    maxAmount: 400
                    color: "#ffffff"
                    colorVariation: Qt.vector4d(0.6, 0.2, 0.2, 0.4)
                    unifiedColorVariation: true
                    fadeInDuration: 3000
                    fadeOutDuration: 1000
                }

                ParticleEmitter3D {
                    particle: spriteParticle
                    emitRate: 20
                    lifeSpan: 10000
                    scale: Qt.vector3d(15, 15, 0)
                    shape: ParticleShape3D {
                        type: ParticleShape3D.Sphere
                    }
                    particleScale: 2.4
                    particleScaleVariation: 1.8
                    particleEndScale: 0.2
                    velocity: TargetDirection3D {
                        magnitudeVariation: magnitude
                        positionVariation: Qt.vector3d(180, 180, 180)
                        SequentialAnimation on magnitude {
                            loops: Animation.Infinite
                            NumberAnimation {
                                to: 1.0
                                from: 3000
                                easing.type: Easing.InOutQuad
                            }
                            NumberAnimation {
                                to: 0.1
                                duration: 5000
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle
    {
        id: maskRect
        width: 1444
        height: 590
        radius: 100
        visible: false
    }

    OpacityMask
    {
        id: opacity
        anchors.fill: splashScreen
        source: splashScreen
        maskSource: maskRect
    }
}

