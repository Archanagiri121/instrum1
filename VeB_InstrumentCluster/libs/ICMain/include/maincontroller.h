#ifndef MAINCONTROLLER_H
#define MAINCONTROLLER_H
#include "../../Navigation/include/navigationcontroller.h"
#include "../../TripInfo/include/tripinfocontroller.h"
#include "../../WarningIndicators/include/warningindicatorcontroller.h"
#include "../../CarModel/include/carmodelcontroller.h"
#include "../../ICMain/include/vehiclemetrics.h"
#include "../../ICMain/include/keyhandler.h"
#include "../../ICSimulation/include/simulationcontroller.h"
#include "../../ICMain/include/menuselection.h"
#include <QObject>
#include <QGuiApplication>
#include <QKeyEvent>

class MainController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(NavigationController *navigationController READ navigationController CONSTANT)
    Q_PROPERTY(TripInfoController *tripInfoController READ tripInfoController CONSTANT)
    Q_PROPERTY(WarningIndicatorController *warningIndicatorController READ warningIndicatorController CONSTANT )
    Q_PROPERTY(CarModelController *carModelController READ carModelController CONSTANT)
    Q_PROPERTY(SimulationController *simulationController READ simulationController CONSTANT)
    Q_PROPERTY(VehicleMetrics *vehicleMetrics READ vehicleMetrics CONSTANT)
    Q_PROPERTY(MenuSelection *menuSelection READ menuSelection CONSTANT)
    Q_PROPERTY(Keyhandler *keyhandler READ keyhandler CONSTANT)


public:
    explicit MainController(QGuiApplication &app, QObject *parent = nullptr);

    NavigationController *navigationController() const;
    TripInfoController *tripInfoController() const;
    WarningIndicatorController *warningIndicatorController() const;
    CarModelController *carModelController() const;
    SimulationController *simulationController() const;
    VehicleMetrics *vehicleMetrics() const;
    Keyhandler *keyhandler() const;
    MenuSelection *menuSelection() const;
    ~MainController();

    void handleAppQuit();



private:
    QGuiApplication &m_app;
    NavigationController *m_navigationController = nullptr;
    TripInfoController *m_TripInfoController = nullptr;
    WarningIndicatorController *m_warningIndicatorController = nullptr;
    CarModelController *m_carModelController = nullptr;
    SimulationController *m_simulationController = nullptr;
    VehicleMetrics *m_vehicleMetrics = nullptr;
    Keyhandler *m_keyhandler = nullptr;
    MenuSelection *m_menuSelection = nullptr;

signals:
};

#endif // MAINCONTROLLER_H
