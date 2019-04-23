#ifndef MOTORCONTROLLER_H
#define MOTORCONTROLLER_H

#include "qmotor.h"

#include <QList>
#include <QObject>
#include <QTimer>

extern void updateGlobalMotors();
class MotorController : public QObject
{
    Q_OBJECT
public:
    MotorController();
    QList<QMotor*> motors;
    static MotorController *getInstance();
    void updateMotors();
public slots:
    void update();
};

#endif // MOTORCONTROLLER_H
