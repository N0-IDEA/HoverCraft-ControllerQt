#ifndef CONFIGCONTROLLER_H
#define CONFIGCONTROLLER_H
#include "axisconfigoption.h"
#include "buttonconfigoption.h"
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

    ConfigOption *downOption  = new ButtonConfigOption("Abajo");
    ConfigOption *upOption  = new AxisConfigOption("Arriba");

    bool updating;
    void finishConfig();

    QMetaObject::Connection temp;
private:

signals:
    void configDone();
public slots:
    void configButton(int);
};

#endif // CONFIGCONTROLLER_H
