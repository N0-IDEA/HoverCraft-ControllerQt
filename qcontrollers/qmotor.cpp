#include "qmotor.h"

#include <QJoysticks.h>
#include <QTimer>

#include <configController/configcontroller.h>

QMotor::QMotor(Motor *motor, ConfigOption *option, ConfigOption *downOption) : QMotor()
{
    this->motor = motor;
    this->option = option;
    this->downOption = downOption;

    //connect(QJoysticks::getInstance(), &QJoysticks::buttonEvent, this, &QMotor::buttonEvent);
    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(change()));
    timer->start(10);
}

void QMotor::change() {
    if(!ConfigController::getInstance()->updating) {
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

        emit valueChanged();

        this->motor->potencia = value;
        if(!updated) {
            time = QDateTime::currentMSecsSinceEpoch();
            updated = true;
        }
        if(updated && QDateTime::currentMSecsSinceEpoch() - time > 50) {
            time = QDateTime::currentMSecsSinceEpoch();
            emit valueDelayedChanged();
        }

    }
}
