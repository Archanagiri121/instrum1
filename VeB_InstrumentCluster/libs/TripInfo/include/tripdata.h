#ifndef TRIPDATA_H
#define TRIPDATA_H

#include <QObject>
#include <QAbstractListModel>
#include <QString>
#include <QVariant>

struct Trip {

    QString from;
    QString to;
    double distance;
    double time;
    double speed;
    double fuel;
};

class TripData : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit TripData();

    // enum Roles {
    //     NameRole = Qt::UserRole + 1,
    //     FromRole,
    //     ToRole,
    //     DistanceRole,
    //     SpeedRole,
    //     FuelRole,
    //     TimeRole
    // };

    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<Trip> m_trips;
};

#endif // TRIPDATA_H
