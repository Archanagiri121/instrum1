#include "include/navigationcontroller.h"
#include "qdebug.h"

NavigationController::NavigationController(QObject *parent)
    : QObject{parent}
{
    qDebug(__FUNCTION__);
}

NavigationController::~NavigationController()
{
    qDebug() << __FUNCTION__ << "Navigation destroyed";
}
