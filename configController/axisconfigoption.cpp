#include "axisconfigoption.h"
#include "configcontroller.h"

#include <QJoysticks.h>
#include <QtDebug>

bool AxisConfigOption::isActive() {
    QJoysticks *instance = QJoysticks::getInstance();
    if (value() == 0.0)
        return false;
    return qFuzzyCompare(instance->getAxis(idGamepad(), idButton()), value());
}

void AxisConfigOption::axisEvent (const QJoystickAxisEvent& event) {
    if (event.value != 0.0) {
        setIdButton(event.axis);
        setIdGamepad(event.joystick->id);
        m_value = event.value;
        //emit valueChanged();
        ConfigController::getInstance()->finishConfig();
    }
}

void AxisConfigOption::config() {
    QJoysticks *instance = QJoysticks::getInstance();
    ConfigController::getInstance()->temp = connect(instance, &QJoysticks::axisEvent, this, &AxisConfigOption::axisEvent);
}

void ConfigOption::setValue(double value) {
    ((AxisConfigOption*) this)->m_value = value;
}

