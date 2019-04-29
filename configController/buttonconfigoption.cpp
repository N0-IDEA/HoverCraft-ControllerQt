#include "buttonconfigoption.h"
#include "configcontroller.h"

bool ButtonConfigOption::isActive() {
    QJoysticks *instance = QJoysticks::getInstance();
    return instance->getButton(idGamepad(), idButton());
}


void ButtonConfigOption::buttonEvent(const QJoystickButtonEvent& event) {
    setIdButton(event.button);
    setIdGamepad(event.joystick->id);
    ConfigController::getInstance()->finishConfig(this);
}

void ButtonConfigOption::config() {
    QJoysticks *instance = QJoysticks::getInstance();
    ConfigController::getInstance()->temp = connect(instance, &QJoysticks::buttonEvent, this, &ButtonConfigOption::buttonEvent);
}
