#include "configcontroller.h"

#include <qcontrollers/windowcontroller.h>

ConfigController::ConfigController(QObject *parent) : QObject(parent)
{
    this->options.append(upOption);
    this->options.append(downOption);
    this->options.append(forwardOption);
    this->options.append(backwardOption);
    this->options.append(leftOption);
    this->options.append(rigthOption);
    updating = false;
}

void ConfigController::finishConfig(ConfigOption* option) {
    dbManager.saveOption(perfil->id, this->options.indexOf(option));
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

void ConfigController::createProfile(QString perfil) {
    this->loadPerfil(perfil);
    WindowController::getInstance()->updateProfiles();
}

bool ConfigController::deleteProfile() {
    if (dbManager.getPerfiles().size() > 1) {
        dbManager.deleProfile((char *)qPrintable(perfil->name()));
        WindowController::getInstance()->updateProfiles();
        this->loadPerfil(dbManager.getPerfiles()[0]->name());
        return true;
    }
    return false;
}

void ConfigController::loadPerfil(QString perfilStr) {
    perfil = dbManager.createPerfil((char *)qPrintable(perfilStr));
    if(!dbManager.loadOptions(perfil->id))
        dbManager.createOptions(perfil->id);
}
