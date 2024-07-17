#ifndef CARMODELCONTROLLER_H
#define CARMODELCONTROLLER_H
#include "configreader.h"
#include <QObject>

class CarModelController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(ConfigReader *configReader READ configReader CONSTANT)
public:
    explicit CarModelController(QObject *parent = nullptr);

    ConfigReader *configReader() const;
    ~CarModelController();

signals:
private:
    ConfigReader *m_configReader = nullptr;
};

#endif // CARMODELCONTROLLER_H
