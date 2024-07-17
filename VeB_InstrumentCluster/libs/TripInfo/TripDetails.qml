import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    property string tripName: ""
    property string fromSource: ""
    property string toSource: ""
    property string distanceValue: ""
    property string speedValue: ""
    property string fuelValue: ""
    property string timeValue: ""
    property string fromValue:""
    property string toValue:""
    focus:true
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10
        width: parent.width
        height: parent.height

        Text {
            text: tripName
            color: "white"
            font.pixelSize: parent.width / 20
            font.family: "Inter"
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        GridLayout {
            Layout.alignment: Qt.AlignHCenter
            columns: 2
            rowSpacing: 5
            columnSpacing: 40
            Layout.fillWidth: true
            Layout.fillHeight: true
            RowItem {
                id: fromItem
                source: fromSource
                textValue:fromValue
                visible: fromSource != "" && tripName != "After Refuelling"
            }
            RowItem {
                id:toIttem
                source: toSource
                textValue:toValue
                visible: toSource != "" && tripName != "After Refuelling"
            }
            RowItem {
                id:distanceItem
                source: "asset/images/distanceIcon.png"
                textValue:  distanceValue
            }
            RowItem {
                id:timeItem
                source: "asset/images/timerIcon.png"
                textValue: timeValue
                visible: timeValue != "" && tripName != "After Refuelling"
            }

            RowItem {
                id:speedItem
                source: "asset/images/speedIcon.png"
                textValue: speedValue
            }
            RowItem {
                id:fuelItem
                source: "asset/images/fuelIcon.png"
                textValue: fuelValue
            }
        }
    }
}


