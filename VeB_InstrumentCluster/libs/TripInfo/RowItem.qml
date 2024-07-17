import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    property string source: ""
    property string textValue: ""
    spacing: 20
    width: parent.width
    height: 40
    Image {
        id:icon
        sourceSize.height: 40
        sourceSize.width: 40
        source: parent.source
        fillMode: Image.PreserveAspectFit
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter
    }
    Text {
        id:label
        text: parent.textValue
        color: "white"
        font.pixelSize: 15
        font.bold: true
        font.family: "Inter"
    }
}
