#ifndef VEHICLEMETRICS_H
#define VEHICLEMETRICS_H

#include <QObject>
#include <QList>

class VehicleMetrics : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int speed READ speed WRITE setSpeed NOTIFY speedChanged FINAL)
    Q_PROPERTY(double batteryPercent READ batteryPercent WRITE setBatteryPercent NOTIFY batteryPercentChanged FINAL)
    Q_PROPERTY(double odoMeter READ odoMeter WRITE setOdoMeter NOTIFY odoMeterChanged FINAL)
    Q_PROPERTY(double rangeMeter READ rangeMeter WRITE setRangeMeter NOTIFY rangeMeterChanged FINAL)
    Q_PROPERTY(int regenLevel READ regenLevel WRITE setRegenLevel NOTIFY regenLevelChanged FINAL)
    Q_PROPERTY(double averageSpeed READ averageSpeed NOTIFY averageSpeedChanged FINAL)
    Q_PROPERTY(bool spacePressed READ spacePressed WRITE setSpacePressed NOTIFY spacePressedChanged FINAL)

public:
    explicit VehicleMetrics(QObject *parent = nullptr);

    int speed() const;
    double batteryPercent() const;
    double odoMeter() const;
    double rangeMeter() const;
    int regenLevel() const;
    double averageSpeed() const;

    bool spacePressed() const;
    void setSpacePressed(bool newSpacePressed);

public slots:
    void setSpeed(int newSpeed);
    void setBatteryPercent(double newBatteryPercent);
    void setOdoMeter(double newOdoMeter);
    void setRangeMeter(double newRangeMeter);
    void setRegenLevel(int newRegenLevel);
    void handleSpeedUpdate(double speed);

signals:
    void speedChanged();
    void batteryPercentChanged();
    void odoMeterChanged();
    void rangeMeterChanged();
    void regenLevelChanged();
    void averageSpeedChanged();

    void spacePressedChanged();

private:
    int m_speed;
    double m_batteryPercent = 100;
    double m_odoMeter = 0;
    const double initialRange = 400;
    double m_rangeMeter;
    int m_regenLevel = 1;
    double m_averageSpeed = 0.0;
    QList<int> m_speedList;
    int m_speedCount = 0;
    const int maxSpeedListSize = 100;
    void calculateAverageSpeed();
    bool m_spacePressed = false;
};

#endif // VEHICLEMETRICS_H
