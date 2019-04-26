#ifndef MOTORCONTROLLER_H
#define MOTORCONTROLLER_H

#include "qmotor.h"
#include "qservo.h"

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
private:
    QServo *timon;
public slots:
    void update();
};

#endif // MOTORCONTROLLER_H
