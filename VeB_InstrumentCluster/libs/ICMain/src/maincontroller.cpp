#include "include/maincontroller.h"
#include <QDebug>

// To be merged

MainController::MainController(QGuiApplication &app, QObject *parent)
    : QObject{parent}, m_app(app)

{
    qDebug(__FUNCTION__);

    m_navigationController = new NavigationController(this);
    m_TripInfoController = new TripInfoController(this);
    m_warningIndicatorController = new WarningIndicatorController(this);
    m_carModelController = new CarModelController(this);
    m_simulationController = new SimulationController(this);
    m_vehicleMetrics = new VehicleMetrics(this);
    m_menuSelection = new MenuSelection(this);

    m_keyhandler = new Keyhandler(m_warningIndicatorController,
                                  m_vehicleMetrics,
                                  m_menuSelection,
                                  m_simulationController,
                                  this);

    connect(m_simulationController->speedSimulator(), &SpeedSimulator::speedUpdated,m_vehicleMetrics, &VehicleMetrics::handleSpeedUpdate);
    connect(m_keyhandler, &Keyhandler::escapeKeyPressed, this, &MainController::handleAppQuit);
}

NavigationController *MainController::navigationController() const
{
    return m_navigationController;
}


TripInfoController *MainController::tripInfoController() const
{
    return m_TripInfoController;
}

WarningIndicatorController *MainController::warningIndicatorController() const
{
    return m_warningIndicatorController;
}

CarModelController *MainController::carModelController() const
{
    return m_carModelController;
}

SimulationController *MainController::simulationController() const
{
    return m_simulationController;
}

VehicleMetrics *MainController::vehicleMetrics() const
{
    return m_vehicleMetrics;
}

MenuSelection *MainController::menuSelection() const
{
    return m_menuSelection;
}

Keyhandler *MainController::keyhandler() const
{
    return m_keyhandler;
}

MainController::~MainController(){
    delete  m_simulationController;
    delete m_carModelController;
    delete  m_warningIndicatorController;
    delete m_TripInfoController;
    delete m_navigationController;

    qDebug() << __FUNCTION__ << "Main Destructor called";
}


void MainController::handleAppQuit()
{
    m_app.quit();
}


