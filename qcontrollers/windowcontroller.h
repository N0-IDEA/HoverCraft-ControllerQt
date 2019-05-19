#ifndef WINDOWCONTROLLER_H
#define WINDOWCONTROLLER_H

#include <qqmlapplicationengine.h>
#include "qmotor.h"
#include <configController/configcontroller.h>
#include <QObject>


class WindowController: public QObject
{
    Q_OBJECT
public:
    explicit WindowController(QObject *parent = nullptr);
    void setEngine(QQmlApplicationEngine *engine) {
        this->engine = engine;
    }
    void initMenu();
    static WindowController *getInstance();
    void updateProfiles();
public slots:
    void initConfig();
    void initMain();
private:
    QQmlApplicationEngine *engine;
};

#endif // WINDOWCONTROLLER_H
