#include "configcontroller.h"

#include <QTimer>

ConfigController::ConfigController(QObject *parent) : QObject(parent)
{
    this->options.append(upOption);
    this->options.append(downOption);

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

ConfigController* ConfigController::getInstance()
{
    static ConfigController controller;
    return &controller;
}
