#ifndef QMOTOR_H
#define QMOTOR_H

#include <QObject>

#include <controller/Motor.h>

#include <configController/configoption.h>

#include <QJoysticks/JoysticksCommon.h>

class QMotor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int value READ value NOTIFY valueChanged)
public:
    QMotor(Motor *motor, ConfigOption *option, ConfigOption *downOption);
    explicit QMotor(QObject *parent = nullptr) : QObject(parent) {}
    int value() const {
        return this->motor->potencia + 1000;
    }
    void setValue(int);
private:
    Motor *motor;
    ConfigOption *option;
    ConfigOption *downOption;
    void buttonEvent(const QJoystickButtonEvent &event);
signals:
    void valueChanged();
public slots:
};

#endif // QMOTOR_H
