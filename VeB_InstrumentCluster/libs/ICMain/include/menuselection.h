#ifndef MENUSELECTION_H
#define MENUSELECTION_H

#include <QObject>

class MenuSelection : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int menuIndex READ menuIndex WRITE setMenuIndex NOTIFY menuIndexChanged)
    Q_PROPERTY(int repeaterCount READ repeaterCount WRITE setRepeaterCount NOTIFY repeaterCountChanged)

public:
    explicit MenuSelection(QObject *parent = nullptr);

    int menuIndex() const;
    int repeaterCount() const;

public slots:
    void setMenuIndex(int index);
    void setRepeaterCount(int count);

signals:
    void menuIndexChanged(int latestIndex);
    void repeaterCountChanged();

private:
    int m_menuIndex = 1;
    int m_repeaterCount = 0;
};

#endif // MENUSELECTION_H
