#include "include/tripinfocontroller.h"
#include "qdebug.h"


TripInfoController::TripInfoController(QObject *parent)
    : QObject{parent}
{

    m_tripData = new TripData;

}



TripData *TripInfoController::tripData() const
{
    return m_tripData;
}
