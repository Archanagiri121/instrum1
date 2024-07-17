#ifndef WARNINGINDICATORCONTROLLER_H
#define WARNINGINDICATORCONTROLLER_H

#include <QObject>

class WarningIndicatorController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool leftIndicatorIsActivated READ leftIndicatorIsActivated WRITE setLeftIndicatorIsActivated NOTIFY leftIndicatorIsActivatedChanged)
    Q_PROPERTY(bool rightIndicatorIsActivated READ isRightIndicatorIsActivated WRITE setRightIndicatorIsActivated NOTIFY rightIndicatorIsActivatedChanged)
    Q_PROPERTY(bool handbrakeIndicatorIsActivated READ isHandbrakeIndicatorIsActivated WRITE setHandbrakeIndicatorIsActivated NOTIFY handbrakeIndicatorIsActivatedChanged)
    Q_PROPERTY(bool doorIndicatorIsActivated READ isDoorIndicatorIsActivated WRITE setDoorIndicatorIsActivated NOTIFY doorIndicatorIsActivatedChanged)
    Q_PROPERTY(bool seatbeltIndicatorIsActivated READ isSeatbeltIndicatorIsActivated WRITE setSeatbeltIndicatorIsActivated NOTIFY seatbeltIndicatorIsActivatedChanged)
    Q_PROPERTY(bool headlightIndicatorIsActivated READ isHeadlightIndicatorIsActivated WRITE setHeadlightIndicatorIsActivated NOTIFY headlightIndicatorIsActivatedChanged)
    Q_PROPERTY(int headlightState READ headlightState WRITE setHeadlightState NOTIFY headlightStateChanged)
    Q_PROPERTY(int gearState READ gearState WRITE setGearState NOTIFY gearStateChanged)

public:
    explicit WarningIndicatorController(QObject *parent = nullptr);

    bool leftIndicatorIsActivated() const;
    bool isRightIndicatorIsActivated() const;
    bool isHandbrakeIndicatorIsActivated() const;
    bool isDoorIndicatorIsActivated() const;
    bool isSeatbeltIndicatorIsActivated() const;
    bool isHeadlightIndicatorIsActivated() const;
    int headlightState() const;
    int gearState() const;

public slots:
    void setLeftIndicatorIsActivated(bool newLeftIndicatorIsActivated);
    void setRightIndicatorIsActivated(bool newRightIndicatorIsActivated);
    void setHandbrakeIndicatorIsActivated(bool newHandbrakeIndicatorIsActivated);
    void setDoorIndicatorIsActivated(bool newDoorIndicatorIsActivated);
    void setSeatbeltIndicatorIsActivated(bool newSeatbeltIndicatorIsActivated);
    void setHeadlightIndicatorIsActivated(bool newHeadlightIndicatorIsActivated);
    void setHeadlightState(int newHeadlightState);
    void setGearState(int newGearState);

signals:
    void leftIndicatorIsActivatedChanged();
    void rightIndicatorIsActivatedChanged();
    void handbrakeIndicatorIsActivatedChanged();
    void doorIndicatorIsActivatedChanged();
    void seatbeltIndicatorIsActivatedChanged();
    void headlightIndicatorIsActivatedChanged();
    void headlightStateChanged();
    void gearStateChanged();

private:
    bool m_leftIndicatorIsActivated = false;
    bool m_rightIndicatorIsActivated = false;
    bool m_handbrakeIndicatorIsActivated = false;
    bool m_doorIndicatorIsActivated = false;
    bool m_seatbeltIndicatorIsActivated = false;
    bool m_headlightIndicatorIsActivated = false;
    int m_headlightState;
    int m_gearState;
};

#endif // WARNINGINDICATORCONTROLLER_H
