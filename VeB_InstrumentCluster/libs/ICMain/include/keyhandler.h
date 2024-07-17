#ifndef KEYHANDLER_H
#define KEYHANDLER_H

#include <QDebug>
#include <QGuiApplication>
#include <QKeyEvent>
#include <QKeySequence>
#include <QObject>
#include "../../ICMain/include/menuselection.h"
#include "../../ICMain/include/vehiclemetrics.h"
#include "../../ICSimulation/include/simulationcontroller.h"
#include "../../WarningIndicators/include/warningindicatorcontroller.h"

class Keyhandler : public QObject
{
    Q_OBJECT

public:
    explicit Keyhandler(WarningIndicatorController *warningIndicatorController,
                        VehicleMetrics *vehicleMetrics,
                        MenuSelection *menuSelection,
                        SimulationController *simulationControl,
                        QObject *parent = nullptr);

public slots:
    void handleKeyPress(int key);
    void handleKeyRelease(int key);

protected:
    bool eventFilter(QObject *watched, QEvent *event) override;

signals:
    void keyEventOccurred(const QString &key);
    void escapeKeyPressed();

private:
    WarningIndicatorController *m_warningIndicatorController;
    MenuSelection *m_menuSelection;
    VehicleMetrics *m_vehicleMetrics;
    SimulationController *m_simulationController;
};

#endif // KEYHANDLER_H
