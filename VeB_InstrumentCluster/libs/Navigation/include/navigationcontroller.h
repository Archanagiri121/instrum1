#ifndef NAVIGATIONCONTROLLER_H
#define NAVIGATIONCONTROLLER_H

#include <QObject>

class NavigationController : public QObject
{
    Q_OBJECT
public:
    explicit NavigationController(QObject *parent = nullptr);
    ~NavigationController();

signals:
};

#endif // NAVIGATIONCONTROLLER_H
