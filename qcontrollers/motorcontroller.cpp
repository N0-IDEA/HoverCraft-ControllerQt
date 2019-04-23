#include "motorcontroller.h"

#include <configController/configcontroller.h>

#include <QtConcurrent/QtConcurrent>

MotorController::MotorController() : QObject(nullptr)
{
    ConfigController *controller = ConfigController::getInstance();
    motors.append(new QMotor(new Motor(0), controller->upOption, controller->downOption));
    motors.append(new QMotor(new Motor(1), controller->forwardOption, controller->backwardOption));

    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(update()));
    timer->start(500);
}

void updateGlobalMotors() {
    MotorController *controller = MotorController::getInstance();
    controller->updateMotors();
}

void MotorController::updateMotors() {
    for (int i=0;i<motors.size(); i++) {
        motors[i]->motor->update();
    }
}

void MotorController::update() {
    QtConcurrent::run(updateGlobalMotors);
}

MotorController* MotorController::getInstance()
{
    static MotorController controller;
    return &controller;
}
