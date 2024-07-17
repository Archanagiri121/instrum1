#include "include/carmodelcontroller.h"
#include "include/configreader.h"
CarModelController::CarModelController(QObject *parent)
    : QObject{parent}
{
    qDebug(__FUNCTION__);
    m_configReader = new ConfigReader();
}

ConfigReader *CarModelController::configReader() const
{
    return m_configReader;
}

CarModelController::~CarModelController()
{
    qDebug() << __FUNCTION__ << "CarModel destroyed.";
}
