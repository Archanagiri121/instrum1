import QtQuick 2.15
import QtQuick.Controls 2.15
import WeatherApp 1.0
import QtQuick.Layouts 1.15

Item {

    anchors.fill: parent

    Rectangle
    {
        id: weatherIconRect
        width: parent.width
        height: parent.height
        color: "#00000000"

        WeatherApi
        {
            id: weatherApi
        }
        ColumnLayout
        {
            anchors.fill: parent
            anchors.centerIn: parent
        RowLayout
        {
            id: weatherIconRow
            spacing: 0

            Rectangle
            {
                id: imgContainer
                width: 90
                height: 90
                color: "#00000000"

                Image
                {
                    id: weatherImg
                    anchors.fill: parent
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    fillMode: Image.PreserveAspectFit
                }
            }

            Rectangle {
                id: textContainer
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#00000000"

                Text
                {
                    id: weatherText
                    anchors.top: parent.top
                    topPadding: 25

                    text: " "
                    font.pixelSize: Math.min(weatherIconRect.width, weatherIconRect.height) * 0.4
                    color: "#ffffff"
                }
            }
        }

        }

        Component.onCompleted:
        {
            weatherApi.weatherInfoChanged.connect(updateWeatherInfo);
        }

        function updateWeatherInfo() {
            weatherText.text = weatherApi.weatherInfo.temperature.toFixed(1) + "°C";
            weatherImg.source = "http://openweathermap.org/img/wn/" + weatherApi.weatherInfo.iconId + "@2x.png";
        }
    }
}
