#include "qmotor.h"

#include <QJoysticks.h>

#include <configController/configcontroller.h>

QMotor::QMotor(Motor *motor, ConfigOption *option, ConfigOption *downOption) : QMotor()
{
    this->motor = motor;
    this->option = option;
    this->downOption = downOption;

    connect(QJoysticks::getInstance(), &QJoysticks::buttonEvent, this, &QMotor::buttonEvent);
}

void QMotor::buttonEvent(const QJoystickButtonEvent& event) {
    if(!ConfigController::getInstance()->updating) {
        if(option->idButton() == event.button && option->idGamepad() == event.joystick->id && event.pressed) {
            if(value() < 1800)
                setValue(this->motor->potencia + 1);
        }
        else if (downOption->idButton() == event.button && downOption->idGamepad() == event.joystick->id && event.pressed) {
            if(value() > 1000)
                setValue(this->motor->potencia - 1);
        }
    }
}

void QMotor::setValue(int value) {
    if (value != this->motor->potencia) {
        this->motor->potencia = value;
        emit valueChanged();
    }
}
