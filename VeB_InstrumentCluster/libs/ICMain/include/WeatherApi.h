#ifndef WEATHERAPI_H
#define WEATHERAPI_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QUrl>
#include "WeatherInfo.h"

class WeatherApi : public QObject
{
    Q_OBJECT
    Q_PROPERTY(WeatherInfo* weatherInfo READ weatherInfo NOTIFY weatherInfoChanged)

public:
    explicit WeatherApi(QObject *parent = nullptr);

    WeatherInfo* weatherInfo() const;

signals:
    void weatherInfoChanged();

public slots:

    void replyFinished(QNetworkReply *reply);

public:
    WeatherInfo *m_weatherInfo;
    QNetworkAccessManager *networkManager;
    double _latitude = 18.5204;
    double _longitude = 73.8567;

};

#endif // WEATHERAPI_H
