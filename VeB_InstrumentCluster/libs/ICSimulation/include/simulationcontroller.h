#ifndef SIMULATIONCONTROLLER_H
#define SIMULATIONCONTROLLER_H

#include "speedsimulator.h"
#include <QObject>

class SimulationController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(SpeedSimulator *speedSimulator READ speedSimulator CONSTANT)

public:
    explicit SimulationController(QObject *parent = nullptr);
    SpeedSimulator *speedSimulator() const;
    ~SimulationController();

signals:

private:
    SpeedSimulator *m_speedSimulator = nullptr;
};

#endif // SIMULATIONCONTROLLER_H
