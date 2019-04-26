#include "qmotor.h"

#include <QJoysticks.h>
#include <QTimer>

#include <configController/configcontroller.h>

QMotor::QMotor(Motor *motor, ConfigOption *option, ConfigOption *downOption) : QMotor()
{
    this->motor = motor;
    this->option = option;
    this->downOption = downOption;

    this->motor->potencia = 1100;
    this->motor->ultimaPotencia = 1100;

    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(change()));
    timer->start(10);
}

void QMotor::change() {
    if(!ConfigController::getInstance()->updating && !motor->error) {
        bool change = false;
        if(option->isActive()) {
            if(value() < 1900) {
                setValue(this->motor->potencia + 1);
                change = true;
            }
        }
        else if (downOption->isActive()) {
            if(value() > 1000)
                setValue(this->motor->potencia - 1);
        }
        else {
            updated = false;
        }
    }
}

void QMotor::setValue(int value) {
    if (value != this->motor->potencia) {
        this->motor->potencia = value;

        emit valueChanged();
        emit valueDelayedChanged();
        if(!updated) {
            time = QDateTime::currentMSecsSinceEpoch();
            updated = true;
        }
        if(updated && QDateTime::currentMSecsSinceEpoch() - time > 50) {
            time = QDateTime::currentMSecsSinceEpoch();
            //emit valueDelayedChanged();
            //motor->update();
        }

    }
}

void QMotor::emitValueEvents() {
    emit valueChanged();
    emit valueDelayedChanged();
}
