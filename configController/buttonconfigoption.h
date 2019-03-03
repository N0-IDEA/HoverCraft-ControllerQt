#ifndef BUTTONCONFIGOPTION_H
#define BUTTONCONFIGOPTION_H

#include "configoption.h"

#include <QJoysticks.h>

class ButtonConfigOption : public ConfigOption
{
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
