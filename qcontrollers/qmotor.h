#ifndef QMOTOR_H
#define QMOTOR_H

#include <QObject>

#include <QDateTime>

#include <controller/Motor.h>

#include <configController/configoption.h>

#include <QJoysticks/JoysticksCommon.h>

class QMotor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int value READ value NOTIFY valueChanged)
    Q_PROPERTY(int valueDelayed READ valueDelayed NOTIFY valueDelayedChanged)
public:
    QMotor(Motor *motor, ConfigOption *option, ConfigOption *downOption);
    explicit QMotor(QObject *parent = nullptr) : QObject(parent) {}

    int value() const {
        return m_value;
    }

    int valueDelayed() const {
        return value();
    }

    void setValue(int);

private:
    int m_value = 1000;
    Motor *motor;
    ConfigOption *option;
    ConfigOption *downOption;
private:
    qint64 time;
    bool updated = false;
signals:
    void valueChanged();
    void valueDelayedChanged();
public slots:
    void change();
};

#endif // QMOTOR_H
