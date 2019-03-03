#ifndef AXISCONFIGOPTION_H
#define AXISCONFIGOPTION_H

#include "configoption.h"

#include <QJoysticks.h>

class AxisConfigOption : public ConfigOption
{
public:
    AxisConfigOption(QString option) : ConfigOption(option)  {
    }
    bool isActive();
    void axisEvent (const QJoystickAxisEvent& event);
    void config();

    qreal value;
};

#endif // AXISCONFIGOPTION_H
