#ifndef SPEEDSIMULATOR_H
#define SPEEDSIMULATOR_H

#include <QObject>
#include <QTimer>
#include <QDebug>

class SpeedSimulator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double speed READ getSpeed NOTIFY speedUpdated)
    Q_PROPERTY(double distanceCovered READ getDistanceCovered NOTIFY distanceUpdated)
public:
    explicit SpeedSimulator(QObject *parent = nullptr);
    Q_INVOKABLE void setTotalDistance(double distance);
    Q_INVOKABLE void startSimulation();

    double getSpeed() const { return speed; }
    double getDistanceCovered() const { return distanceCovered; }


signals:
    void speedUpdated(double speed);
    void distanceUpdated(double distanceCovered);
    void simulationFinished();

private:
    void updateSpeed();
    void calculateAdjustedRates();

    double speed;
    double distanceCovered;
    double totalDistance;
    double elapsedTime;

    double baseAccelRateMin;
    double baseAccelRateMax;
    double baseDecelRate;
    double fluctuationRate;
    double adjustedAccelRateMin;
    double adjustedAccelRateMax;
    double adjustedDecelRate;

    enum Phase {
        ACCEL_TO_60,
        FLUCTUATE_50_60,
        ACCEL_TO_120,
        FLUCTUATE_120_130,
        ACCEL_TO_150,
        FLUCTUATE_140_150,
        DECEL_TO_0
    } currentPhase;

    const double baseDistance = 10.0; // Reference distance for rate adjustments
    const double dt = 0.1; // Time increment in seconds

};

#endif // SPEEDSIMULATOR_H
