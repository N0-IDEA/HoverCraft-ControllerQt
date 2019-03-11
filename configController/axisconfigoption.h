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

    qreal value() const {
        return this->m_value;
    }

    qreal m_value;

    virtual QString configMsg() const {
        return "Mueva un Joystick";
    }
signals:
    void valueChanged();
};

#endif // AXISCONFIGOPTION_H
