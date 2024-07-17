#include "include/WeatherApi.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>

WeatherApi::WeatherApi(QObject *parent)
    : QObject(parent),
    m_weatherInfo(new WeatherInfo(this)),
    networkManager(new QNetworkAccessManager(this))
{

    QString apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=" +
                     QString::number(_latitude) +
                     "&lon=" +
                     QString::number(_longitude) +
                     "&appid=d150de1e47c122cda60ea28992ba1b57";

    networkManager->get(QNetworkRequest(QUrl(apiUrl)));
    connect(networkManager, &QNetworkAccessManager::finished, this, &WeatherApi::replyFinished);
}

WeatherInfo* WeatherApi::weatherInfo() const
{
    return m_weatherInfo;
}



void WeatherApi::replyFinished(QNetworkReply *reply)
{
    if (reply->error() == QNetworkReply::NoError)
    {
        QByteArray responseData = reply->readAll();
        QJsonDocument jsonResponse = QJsonDocument::fromJson(responseData);
        QJsonObject jsonObject = jsonResponse.object();
        double temperature = jsonObject["main"].toObject()["temp"].toDouble() - 273.15; // Assuming temperature is in Kelvin

        QString iconId = jsonObject["weather"].toArray()[0].toObject()["icon"].toString();

        m_weatherInfo->setTemperature(temperature);
        m_weatherInfo->setIconId(iconId);
        emit weatherInfoChanged();
    }
    else
    {
        qDebug() << "Error ----->" << reply->errorString();
    }
    reply->deleteLater();
}


