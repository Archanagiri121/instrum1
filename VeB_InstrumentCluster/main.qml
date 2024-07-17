import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import ICMain
import CarModel



//To get the exact layout for each component make the property [property bool isboundary -> true] as "true".

Window{
    id:ic_main
    width: 1444
    height: 590
    color: "#00000000"
    flags: Qt.FramelessWindowHint
    visible: true

    BoundaryBox{

    }

    Loader {
        id: pageLoader
        anchors.fill: parent
        sourceComponent: icSplashScreen

        onLoaded: {
            if (pageLoader.item) {
                pageLoader.item.forceActiveFocus();
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: false
        onTriggered: {
            pageLoader.sourceComponent = icHome
        }
    }

    Component{
        id: icHome

        ICHomescreen{
            id:homeScreeen

        }
    }

    Component{
        id: icSplashScreen

        SplashScreen{
            id:splashScreen
        }
    }
}
