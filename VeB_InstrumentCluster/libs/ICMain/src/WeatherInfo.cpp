#include "include/WeatherInfo.h"

WeatherInfo::WeatherInfo(QObject *parent) : QObject(parent), m_temperature(0.0), m_iconId("")
{

}

double WeatherInfo::temperature() const
{
    return m_temperature;
}

void WeatherInfo::setTemperature(double temperature)
{
    if (m_temperature != temperature) {
        m_temperature = temperature;
        emit temperatureChanged(temperature);
    }
}

QString WeatherInfo::iconId() const
{
    return m_iconId;
}

void WeatherInfo::setIconId(const QString &iconId)
{
    if (m_iconId != iconId)
    {
        m_iconId = iconId;
        emit iconIdChanged(iconId);
    }
}
