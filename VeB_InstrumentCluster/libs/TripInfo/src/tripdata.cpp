#include "include/tripdata.h"

TripData::TripData() : QAbstractListModel(0)
{
    // m_trips.append(Trip{"Trip A", "Pune", "Nagpur", "100.00km", "100km/hr", "100kwh", "1:32h"});
    // m_trips.append(Trip{"Trip B", "Mumbai", "Goa", "600.00km", "80km/hr", "200kwh", "8:00h"});
    // m_trips.append(Trip{"After Refuelling", "", "", "0.00km", "0km/hr", "0kwh", "0:00h"});

    m_trips << Trip{"Pune","Nagpur",1000.00, 1.23, 144, 32.3};
    m_trips << Trip{"Alandi","Pune",1200.0, 1.23, 144, 32.3};
}

int TripData::rowCount(const QModelIndex& parent) const
{
    if (parent.isValid())
        return 0;

    return m_trips.size();
}

QVariant TripData::data(const QModelIndex& index, int role) const
{
    const int row = index.row();
    if (row < 0 || row >= m_trips.count()){
        return QVariant();
    }

    const QString from_location = m_trips[index.row()].from;
    const QString to_location = m_trips[index.row()].to;
    const double distance = m_trips[index.row()].distance;
    const double time =m_trips[index.row()].time;
    const double speed=m_trips[index.row()].speed;
    const double fuel= m_trips[index.row()].fuel;


    if (role == 0)
    {
        return from_location;
    }
    if (role == 1)
    {
        return to_location;
    }
    if (role == 2)
    {
        return distance;
    }
    if(role==3)
    {
        return speed;
    }
    if (role==4)
    {
        return fuel;

    }
    if (role==5)
    {
        return time;
    }


    return QVariant();
}

QHash<int, QByteArray> TripData::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[0] = "from";
    roles[1] = "to";
    roles[2] = "distance";
    roles[3] = "speed";
    roles[4] = "fuel";
    roles[5] = "time";

    return roles;
}
