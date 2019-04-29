#ifndef QSERVO_H
#define QSERVO_H

#include <QObject>

#include <controller/Motor.h>

#include <configController/configoption.h>

class QServo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int value READ value NOTIFY valueChanged)
public:
    QServo(Motor *motor, ConfigOption *leftOption, ConfigOption *rightOption);
    explicit QServo(QObject *parent = nullptr) : QObject(parent) {}

    int value() const {
        return this->motor->error ? this->motor->ultimaPotencia : this->motor->potencia;
    }

    void setValue(int);
    Motor *motor;
    void emitValueEvents();
private:
    ConfigOption *leftOption;
    ConfigOption *rightOption;
signals:
    void valueChanged();
public slots:
    void change();
};



#endif // QSERVO_H
