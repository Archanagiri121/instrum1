#ifndef TRIPINFOCONTROLLER_H
#define TRIPINFOCONTROLLER_H

#include <QObject>
#include "tripdata.h"

class TripInfoController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(TripData *tripData READ tripData CONSTANT);

public:
    explicit TripInfoController(QObject *parent = nullptr);

    // Add functions to interact with TripData

    TripData *tripData() const;

signals:

private:

    TripData *m_tripData = nullptr;
};

#endif // TRIPINFOCONTROLLER_H
