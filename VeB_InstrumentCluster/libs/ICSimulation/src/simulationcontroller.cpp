#include "include/simulationcontroller.h"
#include "include/speedsimulator.h"

SimulationController::SimulationController(QObject *parent)
    : QObject{parent}
{
    qDebug(__FUNCTION__);
    m_speedSimulator = new SpeedSimulator();
}

SpeedSimulator *SimulationController::speedSimulator() const
{
    return m_speedSimulator;
}

SimulationController::~SimulationController()
{
    qDebug() << __FUNCTION__ << "Simulation destroyed";
}
