#include "configcontroller.h"

ConfigController::ConfigController(QObject *parent) : QObject(parent)
{
    this->options.append(upOption);
    this->options.append(downOption);
    updating = false;
}

void ConfigController::buttonEvent(const QJoystickButtonEvent& event) {
    ConfigOption *option = this->options[this->tempId];
    option->setIdButton(event.button);
    option->setIdGamepad(event.joystick->id);
    emit configDone();
    updating = false;
    disconnect(this->temp);
}

void ConfigController::configButton(int id) {
    QJoysticks *instance = QJoysticks::getInstance();
    this->tempId = id;
    updating = true;

    //Max uno a la vez
    if(this->temp)
        disconnect(this->temp);

    this->temp = connect(instance, &QJoysticks::buttonEvent, this, &ConfigController::buttonEvent);
                         //&ConfigController::buttonEvent);
}

ConfigController* ConfigController::getInstance()
{
    static ConfigController controller;
    return &controller;
}
