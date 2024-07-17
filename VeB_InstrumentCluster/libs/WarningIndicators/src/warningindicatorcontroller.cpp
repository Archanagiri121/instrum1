#include "include/warningindicatorcontroller.h"

WarningIndicatorController::WarningIndicatorController(QObject *parent)
    : QObject{parent}, m_seatbeltIndicatorIsActivated(true), m_doorIndicatorIsActivated(true), m_gearState(0)
{
    qDebug(__FUNCTION__);
}

bool WarningIndicatorController::leftIndicatorIsActivated() const
{
    return m_leftIndicatorIsActivated;
}

void WarningIndicatorController::setLeftIndicatorIsActivated(bool newLeftIndicatorIsActivated)
{
    m_leftIndicatorIsActivated = newLeftIndicatorIsActivated;
    emit leftIndicatorIsActivatedChanged();
}

bool WarningIndicatorController::isRightIndicatorIsActivated() const
{
    return m_rightIndicatorIsActivated;
}

void WarningIndicatorController::setRightIndicatorIsActivated(bool newRightIndicatorIsActivated)
{
    m_rightIndicatorIsActivated = newRightIndicatorIsActivated;
    emit rightIndicatorIsActivatedChanged();
}

bool WarningIndicatorController::isHandbrakeIndicatorIsActivated() const
{
    return m_handbrakeIndicatorIsActivated;
}

void WarningIndicatorController::setHandbrakeIndicatorIsActivated(bool newHandbrakeIndicatorIsActivated)
{
    m_handbrakeIndicatorIsActivated = newHandbrakeIndicatorIsActivated;
    emit handbrakeIndicatorIsActivatedChanged();
}

bool WarningIndicatorController::isDoorIndicatorIsActivated() const
{
    return m_doorIndicatorIsActivated;
}

void WarningIndicatorController::setDoorIndicatorIsActivated(bool newDoorIndicatorIsActivated)
{
    m_doorIndicatorIsActivated = newDoorIndicatorIsActivated;
    emit doorIndicatorIsActivatedChanged();
}

bool WarningIndicatorController::isSeatbeltIndicatorIsActivated() const
{
    return m_seatbeltIndicatorIsActivated;
}

void WarningIndicatorController::setSeatbeltIndicatorIsActivated(bool newSeatbeltIndicatorIsActivated)
{
    m_seatbeltIndicatorIsActivated = newSeatbeltIndicatorIsActivated;
    emit seatbeltIndicatorIsActivatedChanged();
}

bool WarningIndicatorController::isHeadlightIndicatorIsActivated() const
{
    return m_headlightIndicatorIsActivated;
}

void WarningIndicatorController::setHeadlightIndicatorIsActivated(bool newHeadlightIndicatorIsActivated)
{
    m_headlightIndicatorIsActivated = newHeadlightIndicatorIsActivated;
    emit headlightIndicatorIsActivatedChanged();
}

int WarningIndicatorController::headlightState() const
{
    return m_headlightState;
}

void WarningIndicatorController::setHeadlightState(int newHeadlightState)
{
    m_headlightState = newHeadlightState;
    emit headlightStateChanged();
}

int WarningIndicatorController::gearState() const
{
    return m_gearState;

}

void WarningIndicatorController::setGearState(int newGearState)
{
    m_gearState = newGearState;
    emit gearStateChanged();
}
