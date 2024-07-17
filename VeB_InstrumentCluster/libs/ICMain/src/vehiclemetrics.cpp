#include "include/vehiclemetrics.h"
#include <QDebug>

VehicleMetrics::VehicleMetrics(QObject *parent)
    : QObject{parent}, m_rangeMeter(initialRange)
{}

int VehicleMetrics::speed() const
{
    return m_speed;
}

void VehicleMetrics::setSpeed(int newSpeed)
{
    double distanceTraveled = (newSpeed / 3600.0);

    if (m_rangeMeter > 0) {
        setOdoMeter(m_odoMeter + distanceTraveled);
    }

    m_speedList.append(newSpeed);
    m_speedCount++;

    calculateAverageSpeed();

    m_speed = newSpeed;
    emit speedChanged();
}

void VehicleMetrics::handleSpeedUpdate(double speed)
{
    setSpeed(static_cast<int>(speed));
}


void VehicleMetrics::calculateAverageSpeed()
{
    double sum = 0;
    for (int speed : std::as_const(m_speedList)) {
        sum += speed;
    }

    m_averageSpeed = sum / m_speedCount;

    if (m_speedList.size() >= maxSpeedListSize) {
        double bucketSum = sum;
        m_speedList.clear();
        m_speedList.append(bucketSum);
    }
    emit averageSpeedChanged();
}

double VehicleMetrics::batteryPercent() const
{
    return m_batteryPercent;
}

void VehicleMetrics::setBatteryPercent(double newBatteryPercent)
{
    // Ensure battery percent does not go below 0
    if (newBatteryPercent < 0)
        newBatteryPercent = 0;

    if (m_batteryPercent == newBatteryPercent)
        return;

    m_batteryPercent = newBatteryPercent;

    emit batteryPercentChanged();
}

double VehicleMetrics::odoMeter() const
{
    return m_odoMeter;
}

void VehicleMetrics::setOdoMeter(double newOdoMeter)
{
    if (m_odoMeter == newOdoMeter)
        return;

    m_odoMeter = newOdoMeter;

    setRangeMeter(initialRange - m_odoMeter);

    emit odoMeterChanged();
}

double VehicleMetrics::rangeMeter() const
{
    return m_rangeMeter;
}

void VehicleMetrics::setRangeMeter(double newRangeMeter)
{
    if (newRangeMeter < 0)
        newRangeMeter = 0;

    if (m_rangeMeter == newRangeMeter)
        return;

    m_rangeMeter = newRangeMeter;

    setBatteryPercent((m_rangeMeter / initialRange) * 100);

    emit rangeMeterChanged();
}

int VehicleMetrics::regenLevel() const
{
    return m_regenLevel;
}

void VehicleMetrics::setRegenLevel(int newRegenLevel)
{
    if (m_regenLevel == newRegenLevel)
        return;
    m_regenLevel = newRegenLevel;
    emit regenLevelChanged();
}

double VehicleMetrics::averageSpeed() const
{
    return m_averageSpeed;
}

bool VehicleMetrics::spacePressed() const
{
    return m_spacePressed;
}

void VehicleMetrics::setSpacePressed(bool newSpacePressed)
{
    m_spacePressed = newSpacePressed;
    emit spacePressedChanged();
}
