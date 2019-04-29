#include "qservo.h"

#include <qtimer.h>

#include <configController/configcontroller.h>

QServo::QServo(Motor *motor, ConfigOption *leftOption, ConfigOption *rightOption) : QServo()
{
    this->motor = motor;
    this->leftOption = leftOption;
    this->rightOption = rightOption;

    this->motor->potencia = 45;
    this->motor->ultimaPotencia = 45;

    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(change()));
    timer->start(10);
}

void QServo::change() {
    if(!ConfigController::getInstance()->updating && !motor->error) {
        if(leftOption->isActive()) {
            setValue(25);
        }
        else if (rightOption->isActive()) {
            setValue(70);
        }
    }
}

void QServo::setValue(int value) {
    if (value != this->motor->potencia) {
        this->motor->potencia = value;
        emitValueEvents();
    }
}

void QServo::emitValueEvents() {
    emit valueChanged();
}

