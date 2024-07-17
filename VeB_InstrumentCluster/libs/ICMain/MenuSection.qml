import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import CarModel
import Navigation
import TripInfo

Item {
    id: mainWindow
    anchors.fill: parent
    clip: true

    property int currentIndex: mainController.menuSelection.menuIndex
    property int constValue: 5
    property alias popupMenuComponent: bottomPopupMenu

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        focus: true

        RowLayout {
            id: dotRowLayout
            spacing: 10
            Layout.fillWidth: true
            Layout.preferredHeight: constValue
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 15
            opacity: 0.5

            Repeater {
                id: dotRepeater
                model: menuIconRepeater.count
                onCountChanged: {
                    mainController.menuSelection.setRepeaterCount(
                                dotRepeater.count)
                }
                Rectangle {
                    id: dotRectangle
                    Layout.preferredWidth: mainLayout.width * 0.011
                    Layout.preferredHeight: constValue
                    radius: constValue
                    color: index === currentIndex ? Styles.whiteColor : Styles.grayColor
                    MouseArea {
                        anchors.fill: parent
                        onClicked: mainWindow.currentIndex = index
                    }
                }
            }
        }

        Rectangle {
            id: mainContentArea
            Layout.preferredWidth: bottomPopupMenu.visible ? parent.width
                                                             / 1.2 : parent.width * 0.98
            Layout.preferredHeight: bottomPopupMenu.visible ? parent.height / 1.58 : ((parent.height * 0.98) - dotRowLayout.height - 15)
            Layout.alignment: Qt.AlignHCenter
            color: Styles.transparentColor
            clip: true
            Behavior on Layout.preferredHeight {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }

            SwipeView {
                id: swipeView
                anchors.fill: parent
                currentIndex: mainWindow.currentIndex
                interactive: true
                clip: true

                NavigationMap {}
                CentralCarModel {}
                TripInfo {}

                Component.onCompleted: {
                    for (var i = 0; i < swipeView.count; ++i) {
                        swipeView.itemAt(
                                    i).opacity = (i === mainWindow.currentIndex) ? 1 : 0
                    }
                }

                onCurrentIndexChanged: {
                    for (var i = 0; i < swipeView.count; ++i) {
                        swipeView.itemAt(
                                    i).opacity = (i === currentIndex) ? 1 : 0
                    }
                    updateIconSelection()
                    updateSlidingHighlight()
                }
            }
        }

        Popup {
            id: bottomPopupMenu
            width: parent.width * 0.7
            height: mainWindow.height / 8
            visible: false
            x: (parent.width - width) / 2
            y: parent.height - height - 13
            background: Rectangle {
                id: popupBackground
                color: Styles.transparentColor
                radius: constValue
                anchors.fill: parent

                Rectangle {
                    id: slidingHighlightRectangle
                    width: bottomPopupMenu.width / menuIconRow.children.length
                    height: bottomPopupMenu.height * 0.9
                    radius: constValue
                    color: currentIndex
                           === 0 ? Styles.lightBlueColor : currentIndex
                                   === 1 ? Styles.lightPurpleColor : Styles.lightGreenColor
                    anchors.verticalCenter: parent.verticalCenter
                    x: currentIndex >= 0
                       && currentIndex < menuIconRow.children.length ? menuIconRow.children[currentIndex].x + (menuIconRow.children[currentIndex].width - width) / 2 : 0
                    z: -1
                    opacity: 0.6
                    scale: 1.1

                    SequentialAnimation {
                        PropertyAnimation {
                            target: slidingHighlightRectangle
                            property: "scale"
                            from: 1.1
                            to: 0.8
                            duration: 150
                            easing.type: Easing.InOutQuad
                        }
                        PropertyAnimation {
                            target: slidingHighlightRectangle
                            property: "scale"
                            from: 0.8
                            to: 1.1
                            duration: 150
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on x {
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 300
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                RowLayout {
                    id: menuIconRow
                    anchors.fill: parent
                    spacing: 2

                    Repeater {
                        id: menuIconRepeater
                        model: ListModel {
                            ListElement {
                                source: "assets/images/navigationIcon.png"
                            }
                            ListElement {
                                source: "assets/images/homeIcon.png"
                            }
                            ListElement {
                                source: "assets/images/tripIcon.png"
                            }
                        }
                        delegate: Rectangle {
                            id: iconRectangle
                            radius: constValue
                            color: Styles.transparentColor
                            Layout.preferredWidth: bottomPopupMenu.width
                                                   / menuIconRepeater.model.count
                            Layout.preferredHeight: bottomPopupMenu.height

                            Image {
                                id: menuIcon
                                source: model.source
                                width: bottomPopupMenu.width * 0.06
                                height: bottomPopupMenu.height * 0.5
                                anchors.centerIn: parent
                                scale: currentIndex === index ? 1.4 : 1.0

                                Behavior on scale {
                                    NumberAnimation {
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    mainWindow.currentIndex = index
                                    bottomPopupMenu.visible = false
                                }
                            }
                        }
                    }
                }
            }

            enter: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        target: bottomPopupMenu
                        property: "y"
                        from: mainLayout.height
                        to: mainWindow.height - bottomPopupMenu.height
                        duration: 300
                        easing.type: Easing.InOutQuad
                    }
                    PropertyAnimation {
                        target: bottomPopupMenu
                        property: "scale"
                        from: 0.0
                        to: 1.0
                        duration: 300
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            exit: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        target: bottomPopupMenu
                        property: "y"
                        from: mainWindow.height - bottomPopupMenu.height - 13
                        to: mainLayout.height
                        duration: 500
                        easing.type: Easing.InOutQuad
                    }
                    PropertyAnimation {
                        target: bottomPopupMenu
                        property: "scale"
                        from: 1.0
                        to: 0.0
                        duration: 400
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            Timer {
                id: popupCloseTimer
                interval: 1000
                repeat: false
                running: false
                onTriggered: {
                    bottomPopupMenu.close()
                    resetIconScaling()
                }
            }

            onVisibleChanged: {
                if (visible) {
                    popupCloseTimer.start()
                    dotRowLayout.opacity = 1
                } else {
                    popupCloseTimer.stop()
                    dotRowLayout.opacity = 0.5
                }
            }
        }
    }

    Connections {
        target: mainController.menuSelection
        function onMenuIndexChanged(latestIndex) {
            mainWindow.currentIndex = latestIndex
            updateIconSelection()
            popupMenuComponent.open()
        }
    }

    Component.onCompleted: {
        updateIconSelection()
        updateSlidingHighlight()
    }

    function resetIconScaling() {
        for (var i = 0; i < dotRepeater.count; i++) {
            dotRepeater.itemAt(
                        i).color = (i === currentIndex) ? Styles.whiteColor : Styles.grayColor
        }
        updateSlidingHighlight()
    }

    function updateIconSelection() {
        for (var i = 0; i < dotRepeater.count; i++) {
            dotRepeater.itemAt(
                        i).color = (i === currentIndex) ? Styles.whiteColor : Styles.grayColor
        }
        updateSlidingHighlight()
    }

    function updateSlidingHighlight() {
        slidingHighlightRectangle.width = bottomPopupMenu.width / menuIconRow.children.length

        if (currentIndex >= 0 && currentIndex < menuIconRow.children.length) {
            slidingHighlightRectangle.x = menuIconRow.children[currentIndex].x
                    + (menuIconRow.children[currentIndex].width
                       - slidingHighlightRectangle.width) / 2
        }

        slidingHighlightRectangle.color = currentIndex
                === 0 ? Styles.lightBlueColor : currentIndex
                        === 1 ? Styles.lightPurpleColor : currentIndex
                                === 2 ? Styles.lightGreenColor : slidingHighlightRectangle.color
    }
}
