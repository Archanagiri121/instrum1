// import QtQuick
// import QtQuick.Controls
// import QtQuick.Layouts
// Item {
//     property string from: "Pune"
//     property string to: "Nagpur"
//     property string distance: "100.00km"
//     property string speed: "100km/hr"
//     property string fuel: "100kwh"
//     property string time: "1:32h"
//     // anchors.fill: parent
//     focus: true
//     Keys.onLeftPressed: {
//         if (view.currentIndex > 0) {
//             view.currentIndex--
//         }
//     }
//     Keys.onRightPressed: {
//         if (view.currentIndex < view.count - 1) {
//             view.currentIndex++
//         }
//     }
//     ColumnLayout {
//         anchors.centerIn: parent
//         spacing: 10
//         width: parent.width * 0.8
//         height: parent.height * 0.8
//         Text {
//             id:tripLabel
//             text: "Trip Info"
//             color: "white"
//             font.family: "Inter"
//             font.pointSize: parent.width / 25
//             Layout.alignment: Qt.AlignHCenter
//         }

//         Rectangle {
//             id: progressBar
//             width: 170
//             height: 8
//             color: "transparent"
//             border.color: "black"
//             border.width: 1
//             radius: height / 2
//             Layout.alignment: Qt.AlignHCenter
//             Layout.bottomMargin: 10
//             Rectangle {
//                 id: progressFill
//                 width: progressBar.width * (view.currentIndex + 1) / view.count
//                 height: progressBar.height
//                 radius: progressBar.radius
//                 color: progressFill.width < progressBar.width / 3 ? "lightgreen" : (progressFill.width < 2 * progressBar.width / 3 ? "yellowgreen" : "green")
//             }
//         }
//         SwipeView {
//             id: view
//             currentIndex: 0
//             Layout.fillWidth: true
//             Layout.fillHeight: true
//             focus: true
//             clip: true

//             onCurrentIndexChanged: {
//                 progressFill.width = progressBar.width * (view.currentIndex + 1) / view.count
//             }

//             TripDetails {
//                 id:tripA
//                 tripName: "Trip A"
//                 fromSource: "asset/images/fromIcon.png"
//                 toSource: "asset/images/toIcon.png"
//                 fromValue:from
//                 toValue:to
//                 distanceValue: distance
//                 speedValue: speed
//                 fuelValue: fuel
//                 timeValue: time
//             }

//             TripDetails {
//                 id:tripB
//                 tripName: "Trip B"
//                 fromSource: "asset/images/fromIcon.png"
//                 toSource: "asset/images/toIcon.png"
//                 fromValue:from
//                 toValue:to
//                 distanceValue: distance
//                 speedValue: speed
//                 fuelValue: fuel
//                 timeValue: time
//             }

//             TripDetails {
//                 id:tripC
//                 tripName: "After Refuelling"
//                 fromSource: ""
//                 toSource: ""
//                 distanceValue: distance
//                 speedValue: speed
//                 fuelValue: fuel
//                 timeValue: ""
//             }
//         }
//         RoundButton {
//             id:resetButton
//             text: "OK"
//             Layout.alignment: Qt.AlignBottom
//             Layout.bottomMargin: parent.height * 0.05
//             Layout.leftMargin: parent.width * 0.50
//             width: parent.width * 0.2
//             height: parent.height * 0.1
//             font.pixelSize: parent.width / 30
//             onClicked: {
//                 switch (view.currentIndex) {
//                 case 0:
//                     tripA.distanceValue = "0.00"
//                     tripA.fuelValue = "0.00"
//                     tripA.speedValue = "0.00"
//                     tripA.fromValue = "-"
//                     tripA.toValue = "-"
//                     tripA.timeValue = "0.00"
//                     break
//                 case 1:
//                     tripB.distanceValue = "0.00"
//                     tripB.fuelValue = "0.00"
//                     tripB.speedValue = "0.00"
//                     tripB.fromValue = "-"
//                     tripB.toValue = "-"
//                     tripB.timeValue = "0.00"
//                     break
//                 case 2:
//                     tripC.distanceValue = "0.00"
//                     tripC.fuelValue = "0.00"
//                     tripC.speedValue = "0.00"
//                     tripC.fromValue = "-"
//                     tripC.toValue = "-"
//                     tripC.timeValue = "0.00"
//                     break
//                 }
//             }
//         }
//     }
// }







// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15
// import ICMain

// Item {
//     width: 600
//     height: 800

//     ColumnLayout {
//         anchors.centerIn: parent
//         spacing: 10
//         width: parent.width * 0.8
//         height: parent.height * 0.8

//         Component.onCompleted: {
//             console.log("List view Data:::::::",listView_tripA.model)
//         }

//         Text {
//             id: tripLabel
//             text: "Trip Info"
//             color: "white"
//             font.family: "Inter"
//             font.pointSize: parent.width / 25
//             Layout.alignment: Qt.AlignHCenter
//         }

//         Rectangle {
//             id: progressBar
//             width: 170
//             height: 8
//             color: "transparent"
//             border.color: "black"
//             border.width: 1
//             radius: height / 2
//             Layout.alignment: Qt.AlignHCenter
//             Layout.bottomMargin: 10

//             Rectangle {
//                 id: progressFill
//                 width: progressBar.width * (view.currentIndex + 1) / view.count
//                 height: progressBar.height
//                 radius: progressBar.radius
//                 color: progressFill.width < progressBar.width / 3 ? "lightgreen" : (progressFill.width < 2 * progressBar.width / 3 ? "yellowgreen" : "green")
//             }
//         }

//         SwipeView {
//             id: view
//             currentIndex: 0
//             Layout.fillWidth: true
//             Layout.fillHeight: true
//             focus: true
//             clip: true

//             onCurrentIndexChanged: {
//                 progressFill.width = progressBar.width * (view.currentIndex + 1) / view.count
//             }

//             ListView {
//                 id: listView_tripA
//                 width: 300
//                 height: 300
//                 model: mainController.tripInfoController.tripData

//                 delegate:
//                     Rectangle{
//                     id: tripRect
//                     width: parent.width
//                     height: 250
//                     color: "red"

//                     TripDetails {
//                     tripName: "Trip A"
//                     fromValue: "pune"
//                     // toValue: to
//                     // distanceValue: index=== 0 ? distance : ""
//                     // speedValue: model.speed
//                     // fuelValue: model.fuel
//                     // timeValue: model.time
//                 }
//                 }
//             }

//             // ListView {
//             //     id: listView_tripB
//             //     width: 300
//             //     height: 300
//             //     model: mainController.tripInfoController.tripData

//             //     delegate:Rectangle{
//             //         id: tripRectangle
//             //         width: parent.width
//             //         height: 250
//             //         color: Styles

//             //         TripDetails {
//             //         tripName: "Trip A"
//             //         fromValue: index === 1 ? from : ""
//             //         toValue: index=== 1? to : ""
//             //         distanceValue: index=== 1 ? distance : ""
//             //         // speedValue: model.speed
//             //         // fuelValue: model.fuel
//             //         // timeValue: model.time
//             //     }
//             //     }
//             // }
//         }

//         RoundButton {
//             id: resetButton
//             text: "OK"
//             Layout.alignment: Qt.AlignBottom
//             Layout.bottomMargin: parent.height * 0.05
//             Layout.leftMargin: parent.width * 0.50
//             width: parent.width * 0.2
//             height: parent.height * 0.1
//             font.pixelSize: parent.width / 30

//             onClicked: {
//                 switch (view.currentIndex) {
//                 case 0:
//                     tripDataModel.setData(tripDataModel.index(0), {name: "Trip A", from: "-", to: "-", distance: "0.00", speed: "0.00", fuel: "0.00", time: "0.00"});
//                     break;
//                 case 1:
//                     tripDataModel.setData(tripDataModel.index(1), {name: "Trip B", from: "-", to: "-", distance: "0.00", speed: "0.00", fuel: "0.00", time: "0.00"});
//                     break;
//                 case 2:
//                     tripDataModel.setData(tripDataModel.index(2), {name: "After Refuelling", from: "", to: "", distance: "0.00", speed: "0.00", fuel: "0.00", time: "0.00"});
//                     break;
//                 }
//             }
//         }
//     }
// }





// import QtQuick
// import QtQuick.Controls
// import QtQuick.Layouts
// import ICMain

// Item {
//     property string from: "Pune"
//     property string to: "Nagpur"
//     property string distance: "100.00km"
//     property string speed: "100km/hr"
//     property string fuel: "100kwh"
//     property string time: "1:32h"
//     // anchors.fill: parent
//     focus: true
//     Keys.onLeftPressed: {
//         if (view.currentIndex > 0) {
//             view.currentIndex--
//         }
//     }
//     Keys.onRightPressed: {
//         if (view.currentIndex < view.count - 1) {
//             view.currentIndex++
//         }
//     }

//     Component.onCompleted: {
//         console.log("List view Data", listView.model)
//     }

//     ColumnLayout {
//         anchors.centerIn: parent
//         spacing: 10
//         width: parent.width * 0.8
//         height: parent.height * 0.8
//         Text {
//             id: tripLabel
//             text: "Trip Info"
//             color: "white"
//             font.family: "Inter"
//             font.pointSize: parent.width / 25
//             Layout.alignment: Qt.AlignHCenter
//         }

//         Rectangle {
//             id: progressBar
//             width: 170
//             height: 8
//             color: "transparent"
//             border.color: "black"
//             border.width: 1
//             radius: height / 2
//             Layout.alignment: Qt.AlignHCenter
//             Layout.bottomMargin: 10
//             Rectangle {
//                 id: progressFill
//                 width: progressBar.width * (view.currentIndex + 1) / view.count
//                 height: progressBar.height
//                 radius: progressBar.radius
//                 color: progressFill.width < progressBar.width
//                        / 3 ? "lightgreen" : (progressFill.width < 2 * progressBar.width
//                                              / 3 ? "yellowgreen" : "green")
//             }
//         }

//         SwipeView {
//             id: view
//             currentIndex: 0
//             Layout.fillWidth: true
//             Layout.fillHeight: true
//             focus: true
//             clip: true

//             onCurrentIndexChanged: {
//                 progressFill.width = progressBar.width * (view.currentIndex + 1) / view.count
//             }

//             // TripA page
//             ListView {
//                 id: listView
//                 clip: true
//                 width: 600
//                 height: 600
//                 model: mainController.tripInfoController.tripData
//                 spacing: 7

//                 delegate: Rectangle {
//                     id: tripRect
//                     width: parent.width
//                     height: parent.height
//                     color: Styles.transparentColor
//                     anchors.centerIn: parent

//                     TripDetails {
//                         id: tripA
//                         tripName: index === 0 ? "Trip A" : ""
//                         anchors.left: parent.left
//                         anchors.leftMargin: 100
//                         fromSource: "asset/images/fromIcon.png"
//                         fromValue: index === 0 ? from : ""
//                         toSource: "asset/images/toIcon.png"
//                         toValue: index===0 ? to : ""
//                         distanceValue: index===0 ? distance: ""
//                         speedValue: index===0? speed:""
//                         fuelValue: index===0 ? fuel: ""
//                         timeValue:  index===0 ? time: ""

//                         // toValue: index === 0 ? modelData.toLocation : ""
//                         // distanceValue: index === 0 ? modelData.distance : 0
//                         // speedValue: index === 0 ? modelData.speed : 0
//                         // fuelValue: index === 0 ? modelData.fuel : 0
//                         // timeValue: index === 0 ? modelData.time : ""
//                     }
//                 }
//             }

//             // TripB page
//             ListView {
//                 id: listView2
//                 clip: true
//                 width: 600
//                 height: 600
//                 model: mainController.tripInfoController.tripData
//                 spacing: 7

//                 delegate: Rectangle {
//                     id: tripRect2
//                     width: parent.width
//                     height: parent.height
//                     color: Styles.transparentColor
//                     anchors.centerIn: parent

//                     TripDetails {
//                         id: tripB
//                         tripName: index === 1 ? "Trip B" : ""

//                         anchors.left: parent.left
//                         anchors.leftMargin: 100
//                          fromSource: "asset/images/fromIcon.png"
//                          toSource: "asset/images/toIcon.png"
//                         fromValue: index === 1 ? from : ""

//                         toValue: index===1? to: ""
//                         distanceValue: index===1? distance: ""
//                         timeValue: index===1? time: ""
//                         speedValue: index===1? speed:""
//                         fuelValue: index===1? fuel:""
//                         // toValue: index === 1 ? modelData.toLocation : ""
//                         // distanceValue: index === 1 ? modelData.distance : 0
//                         // speedValue: index === 1 ? modelData.speed : 0
//                         // fuelValue: index === 1 ? modelData.fuel : 0
//                         // timeValue: index === 1 ? modelData.time : ""
//                     }
//                 }
//             }

//             TripDetails {
//                 id: tripC
//                 tripName: "After Refuelling"
//                 fromSource: ""
//                 toSource: ""
//                 distanceValue: distance
//                 speedValue: speed
//                 fuelValue: fuel
//                 timeValue: ""
//             }
//         }
//         Rectangle {
//             id: resetButton
//             color: "red"
//             Layout.alignment: Qt.AlignBottom
//             Layout.bottomMargin: parent.height * 0.05
//             Layout.leftMargin: parent.width * 0.41
//             width: parent.width / 20
//             height: 50

//             Text {
//                 id: btnText
//                 text: qsTr("Ok")
//                 anchors.centerIn: parent
//                 font.pixelSize: parent.width * 0.68
//             }
//             MouseArea {
//                 anchors.fill: parent
//                 onClicked: {
//                     switch (view.currentIndex) {
//                     case 0:
//                         tripA.distanceValue = "0.00"
//                         tripA.fuelValue = "0.00"
//                         tripA.speedValue = "0.00"
//                         tripA.fromValue = "-"
//                         tripA.toValue = "-"
//                         tripA.timeValue = "0.00"
//                         break
//                     case 1:
//                         tripB.distanceValue = "0.00"
//                         tripB.fuelValue = "0.00"
//                         tripB.speedValue = "0.00"
//                         tripB.fromValue = "-"
//                         tripB.toValue = "-"
//                         tripB.timeValue = "0.00"
//                         break
//                     case 2:
//                         tripC.distanceValue = "0.00"
//                         tripC.fuelValue = "0.00"
//                         tripC.speedValue = "0.00"
//                         tripC.fromValue = "-"
//                         tripC.toValue = "-"
//                         tripC.timeValue = "0.00"
//                         break
//                     }
//                 }
//             }
//         }
//     }
// }




import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import ICMain 1.0

Item {
    property string from: "Pune"
    property string to: "Nagpur"
    property string distance: "100.00km"
    property string speed: "100km/hr"
    property string fuel: "100kwh"
    property string time: "1:32h"

    focus: true

    Keys.onLeftPressed: {
        if (view.currentIndex > 0) {
            view.currentIndex--
        }
    }
    Keys.onRightPressed: {
        if (view.currentIndex < view.count - 1) {
            view.currentIndex++
        }
    }

    Component.onCompleted: {
        console.log("List view Data", listView.model)
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10
        width: parent.width * 0.8
        height: parent.height * 0.8

        Text {
            id: tripLabel
            text: "Trip Info"
            color: "white"
            font.family: "Inter"
            font.pointSize: parent.width / 25
            Layout.alignment: Qt.AlignHCenter
        }

        Rectangle {
            id: progressBar
            width: 170
            height: 8
            color: "transparent"
            border.color: "black"
            border.width: 1
            radius: height / 2
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 10

            Rectangle {
                id: progressFill
                width: progressBar.width * (view.currentIndex + 1) / view.count
                height: progressBar.height
                radius: progressBar.radius
                color: progressFill.width < progressBar.width / 3 ? "lightgreen" :
                        (progressFill.width < 2 * progressBar.width / 3 ? "yellowgreen" : "green")
            }
        }

        SwipeView {
            id: view
            currentIndex: 0
            Layout.fillWidth: true
            Layout.fillHeight: true
            focus: true
            clip: true

            onCurrentIndexChanged: {
                progressFill.width = progressBar.width * (view.currentIndex + 1) / view.count
            }

            // TripA page
            ListView {
                id: listView
                clip: true
                width: 600
                height: 600
                model: mainController.tripInfoController.tripData
                spacing: 7

                delegate: Rectangle {
                    width: parent.width
                    height: parent.height
                    color: Styles.transparentColor
                    anchors.centerIn: parent

                    TripDetails {
                        id: tripA
                        tripName: index === 0 ? "Trip A" : ""
                        anchors.left: parent.left
                        anchors.leftMargin: 100
                        fromSource: index===0 ? "asset/images/fromIcon.png" : ""
                        fromValue: index === 0 ? from : ""
                        toSource: index===0 ?  "asset/images/toIcon.png" : ""
                        toValue: index === 0 ? to : ""
                        distanceValue: index === 0 ? distance : ""
                        speedValue: index === 0 ? speed : ""
                        fuelValue: index === 0 ? fuel : ""
                        timeValue: index === 0 ? time : ""
                    }
                }
            }

            // TripB page
            ListView {
                id: listView2
                clip: true
                width: 600
                height: 600
                model: mainController.tripInfoController.tripData
                spacing: 7

                delegate: Rectangle {
                    width: parent.width
                    height: parent.height
                    color: Styles.transparentColor
                    anchors.centerIn: parent

                    TripDetails {
                        id: tripB
                        tripName: index === 1 ? "Trip B" : ""
                        anchors.left: parent.left
                        anchors.leftMargin: 100
                        fromSource: "asset/images/fromIcon.png"
                        fromValue: index === 1 ? from : ""
                        toSource: "asset/images/toIcon.png"
                        toValue: index === 1 ? to : ""
                        distanceValue: index === 1 ? distance : ""
                        speedValue: index === 1 ? speed : ""
                        fuelValue: index === 1 ? fuel : ""
                        timeValue: index === 1 ? time : ""
                    }
                }
            }

            // TripC page
            TripDetails {
                id: tripC
                tripName: "After Refuelling"
                fromSource: ""
                toSource: ""
                distanceValue: distance
                speedValue: speed
                fuelValue: fuel
                timeValue: ""
            }
        }

        Rectangle {
            id: resetButton
            color: "red"
            Layout.alignment: Qt.AlignBottom
            Layout.bottomMargin: parent.height * 0.05
            Layout.leftMargin: parent.width * 0.41
            width: parent.width / 20
            height: 50

            Text {
                id: btnText
                text: qsTr("Ok")
                anchors.centerIn: parent
                font.pixelSize: parent.width * 0.68
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    switch (view.currentIndex) {
                    case 0:
                        tripA.distanceValue = "0.00"
                        tripA.fuelValue = "0.00"
                        tripA.speedValue = "0.00"
                        tripA.fromValue = "-"
                        tripA.toValue = "-"
                        tripA.timeValue = "0.00"
                        break
                    case 1:
                        tripB.distanceValue = "0.00"
                        tripB.fuelValue = "0.00"
                        tripB.speedValue = "0.00"
                        tripB.fromValue = "-"
                        tripB.toValue = "-"
                        tripB.timeValue = "0.00"
                        break
                    case 2:
                        tripC.distanceValue = "0.00"
                        tripC.fuelValue = "0.00"
                        tripC.speedValue = "0.00"
                        tripC.fromValue = "-"
                        tripC.toValue = "-"
                        tripC.timeValue = "0.00"
                        break
                    }
                }
            }
        }
    }
}


