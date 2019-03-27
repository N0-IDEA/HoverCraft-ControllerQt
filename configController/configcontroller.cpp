#include "configcontroller.h"

#include <QTimer>

ConfigController::ConfigController(QObject *parent) : QObject(parent)
{
    this->options.append(upOption);
    this->options.append(downOption);
    this->options.append(forwardOption);
    this->options.append(backwardOption);

    updating = false;
}

void ConfigController::finishConfig() {
    emit configDone();
    updating = false;
    disconnect(this->temp);
}

void ConfigController::configButton(int id) {
    updating = true;

    //Max uno a la vez
    if(this->temp)
        disconnect(this->temp);
    options[id]->config();
}

QList<AxisConfigOption*> ConfigController::getAxisOptions() {
    QList<AxisConfigOption*> objects;
    for(int i=0;i<options.size();i++) {
        if(AxisConfigOption* option = dynamic_cast<AxisConfigOption*>(options[i])) {
              objects.append(option);
        }
    }
    return objects;
}

QList<ButtonConfigOption*> ConfigController::getButtonOptions() {
    QList<ButtonConfigOption*> objects;
    for(int i=0;i<options.size();i++) {
        if(ButtonConfigOption* option = dynamic_cast<ButtonConfigOption*>(options[i])) {
              objects.append(option);
        }
    }
    return objects;
}

ConfigController* ConfigController::getInstance()
{
    static ConfigController controller;
    return &controller;
}
