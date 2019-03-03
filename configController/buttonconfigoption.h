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
};

#endif // BUTTONCONFIGOPTION_H
