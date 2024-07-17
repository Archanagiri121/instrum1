#include "include/keyhandler.h"
#include "../../ICMain/include/menuselection.h"
#include "../../ICMain/include/vehiclemetrics.h"
#include "../../ICSimulation/include/simulationcontroller.h"
#include "../../WarningIndicators/include/warningindicatorcontroller.h"

Keyhandler::Keyhandler(WarningIndicatorController *warningIndicatorController,
                       VehicleMetrics *vehicleMetrics,
                       MenuSelection *menuSelection,
                       SimulationController *simulationControl,
                       QObject *parent)
    : QObject(parent)
    , m_warningIndicatorController(warningIndicatorController)
    , m_vehicleMetrics(vehicleMetrics)
    , m_menuSelection(menuSelection)
    , m_simulationController(simulationControl)
{
    qDebug() << "Keys Initialized";
    QGuiApplication::instance()->installEventFilter(this);
}

bool Keyhandler::eventFilter(QObject *watched, QEvent *event)
{
    if (event->type() == QEvent::KeyPress) {
        QKeyEvent *keyEvent = static_cast<QKeyEvent *>(event);
        handleKeyPress(keyEvent->key());
        return true;
    } else if (event->type() == QEvent::KeyRelease) {
        QKeyEvent *keyEvent = static_cast<QKeyEvent *>(event);
        handleKeyRelease(keyEvent->key());
        return true;
    }

    return QObject::eventFilter(watched, event);
}

void Keyhandler::handleKeyPress(int key)
{
    switch (key) {
    case Qt::Key_D:
        if (m_warningIndicatorController->isDoorIndicatorIsActivated() == false) {
            m_warningIndicatorController->setDoorIndicatorIsActivated(true);
        } else {
            m_warningIndicatorController->setDoorIndicatorIsActivated(false);
        }
        break;

    case Qt::Key_S:
        if (m_warningIndicatorController->isSeatbeltIndicatorIsActivated() == false) {
            m_warningIndicatorController->setSeatbeltIndicatorIsActivated(true);
        } else {
            m_warningIndicatorController->setSeatbeltIndicatorIsActivated(false);
        }
        break;

    case Qt::Key_B:
        if (m_warningIndicatorController->isHandbrakeIndicatorIsActivated() == false) {
            m_warningIndicatorController->setHandbrakeIndicatorIsActivated(true);
        } else {
            m_warningIndicatorController->setHandbrakeIndicatorIsActivated(false);
        }
        break;

    case Qt::Key_Comma:
        if (m_warningIndicatorController->leftIndicatorIsActivated() == false) {
            m_warningIndicatorController->setLeftIndicatorIsActivated(true);
            m_warningIndicatorController->setRightIndicatorIsActivated(false);
        } else {
            m_warningIndicatorController->setLeftIndicatorIsActivated(false);
        }
        break;

    case Qt::Key_Period:
        if (m_warningIndicatorController->isRightIndicatorIsActivated() == false) {
            m_warningIndicatorController->setRightIndicatorIsActivated(true);
            m_warningIndicatorController->setLeftIndicatorIsActivated(false);
        } else {
            m_warningIndicatorController->setRightIndicatorIsActivated(false);
        }
        break;

    case Qt::Key_H:
        if (m_warningIndicatorController->isHeadlightIndicatorIsActivated() == false) {
            m_warningIndicatorController->setHeadlightIndicatorIsActivated(true);
            if (m_warningIndicatorController->headlightState() == 1) {
                m_warningIndicatorController->setHeadlightState(0);
            }
        } else {
            m_warningIndicatorController->setHeadlightIndicatorIsActivated(false);
            m_warningIndicatorController->setHeadlightState(0);
        }
        break;

    case Qt::Key_Up:
        if (m_warningIndicatorController->isHeadlightIndicatorIsActivated()) {
            m_warningIndicatorController->setHeadlightState(
                (m_warningIndicatorController->headlightState() + 1) % 2);
        }
        break;
    case Qt::Key_C:
        m_warningIndicatorController->setGearState(0);
        m_warningIndicatorController->setLeftIndicatorIsActivated(false);
        m_warningIndicatorController->setRightIndicatorIsActivated(false);
        break;

    case Qt::Key_V:
        m_warningIndicatorController->setGearState(1);
        m_warningIndicatorController->setLeftIndicatorIsActivated(false);
        m_warningIndicatorController->setRightIndicatorIsActivated(false);
        break;

    case Qt::Key_N:
        m_warningIndicatorController->setGearState(2);
        m_warningIndicatorController->setLeftIndicatorIsActivated(false);
        m_warningIndicatorController->setRightIndicatorIsActivated(false);
        break;

    case Qt::Key_M:
        m_warningIndicatorController->setGearState(3);
        m_warningIndicatorController->setLeftIndicatorIsActivated(true);
        m_warningIndicatorController->setRightIndicatorIsActivated(true);
        break;

    case Qt::Key_Left:
        m_menuSelection->setMenuIndex(
            (m_menuSelection->menuIndex() - 1 + m_menuSelection->repeaterCount())
            % m_menuSelection->repeaterCount());
        break;

    case Qt::Key_Right:
        m_menuSelection->setMenuIndex((m_menuSelection->menuIndex() + 1)
                                      % m_menuSelection->repeaterCount());

        break;

    case Qt::Key_Space:
        m_vehicleMetrics->setSpacePressed(true);
        break;

    case Qt::Key_Escape:
        emit escapeKeyPressed();
        break;

    case Qt::Key_T:
        m_simulationController->speedSimulator()->setTotalDistance(2);
        m_simulationController->speedSimulator()->startSimulation();
        break;
    default:
        NULL;
        break;
    }
}

void Keyhandler::handleKeyRelease(int key)
{
    if (key == Qt::Key_Space) {
        m_vehicleMetrics->setSpacePressed(false);
    }
}
