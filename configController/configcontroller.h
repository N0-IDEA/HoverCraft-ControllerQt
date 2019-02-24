#ifndef CONFIGCONTROLLER_H
#define CONFIGCONTROLLER_H
#include "configoption.h"

#include <QJoysticks.h>
#include <QObject>

class ConfigController : public QObject
{
    Q_OBJECT
public:
    explicit ConfigController(QObject *parent = nullptr);
    QList<ConfigOption*> options;
    static ConfigController *getInstance();

    ConfigOption *downOption  = new ConfigOption("Abajo");
    ConfigOption *upOption  = new ConfigOption("Arriba");

    bool updating;
private:
    QMetaObject::Connection temp;

    int tempId;

signals:
    void configDone();
public slots:
    void configButton(int);
protected slots:
    void buttonEvent(const QJoystickButtonEvent &event);
};

#endif // CONFIGCONTROLLER_H
