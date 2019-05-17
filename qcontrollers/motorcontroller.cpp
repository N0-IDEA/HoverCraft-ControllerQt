#include "motorcontroller.h"

#include <configController/configcontroller.h>

#include <QtConcurrent/QtConcurrent>

MotorController::MotorController() : QObject(nullptr)
{
    ConfigController *controller = ConfigController::getInstance();
    motors.append(new QMotor(new Motor(0), controller->upOption, controller->downOption));
    motors.append(new QMotor(new Motor(1), controller->forwardOption, controller->backwardOption));

    servos.append(new QServo(new Motor(2), controller->leftOption, controller->rigthOption));

    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(update()));
    timer->start(10);
}

void updateGlobalMotors() {
    MotorController *controller = MotorController::getInstance();
    controller->updateMotors();
}

void MotorController::updateMotors() {
    for (int i=0;i<motors.size(); i++) {
        motors[i]->motor->update();
        motors[i]->emitValueEvents();
    }
    for (int i=0;i<servos.size(); i++) {
        servos[i]->motor->update();
        servos[i]->emitValueEvents();
    }
    //timon->motor->update();
    //timon->emitValueEvents();
}

void MotorController::update() {
    QtConcurrent::run(updateGlobalMotors);
}

MotorController* MotorController::getInstance()
{
    static MotorController controller;
    return &controller;
}
