#include "qservo.h"

#include <qtimer.h>

#include <configController/configcontroller.h>

QServo::QServo(Motor *motor, ConfigOption *leftOption, ConfigOption *rightOption, ConfigOption *lockOption) : QServo()
{
    this->motor = motor;
    this->leftOption = leftOption;
    this->rightOption = rightOption;
    this->lockOption = lockOption;

    this->motor->potencia = 58;
    this->motor->ultimaPotencia = 58;

    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(change()));
    timer->start(10);
}

void QServo::change() {
    if(!ConfigController::getInstance()->updating && !motor->error) {
        bool change = false;
        if(leftOption->isActive()) {
            if(value() > 25) {
                setValue(value()-1);//this->motor->potencia - 1);
                change = true;
            }
        }
        else if (rightOption->isActive()) {
            if(value() < 90)
                setValue(value()+1);//this->motor->potencia + 1);
        }
        else {
            if(value() != 50 && !lockOption->isActive())
                setValue(50);
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

