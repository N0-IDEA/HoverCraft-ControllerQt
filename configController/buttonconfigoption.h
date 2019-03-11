#ifndef BUTTONCONFIGOPTION_H
#define BUTTONCONFIGOPTION_H

#include "configoption.h"

#include <QJoysticks.h>

class ButtonConfigOption : public ConfigOption
{
    Q_PROPERTY(QString option READ option)
    Q_PROPERTY(int idButton READ idButton NOTIFY idButtonChanged)
    Q_PROPERTY(int idGamepad READ idGamepad NOTIFY idGamepadChanged)
public:
    ButtonConfigOption(QString option) : ConfigOption(option)  {
    }
    bool isActive();
    void buttonEvent(const QJoystickButtonEvent &event);
    void config();

    virtual QString configMsg() const {
        return "Pulse cualquier boton";
    }
};

#endif // BUTTONCONFIGOPTION_H
