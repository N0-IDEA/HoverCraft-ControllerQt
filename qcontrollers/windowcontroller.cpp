#include "windowcontroller.h"

/*
WindowController::WindowController(QQmlApplicationEngine *engine) : WindowController()
{
    this->engine = engine;
}*/

WindowController::WindowController(QObject *parent) : QObject(parent)
{

}

void WindowController::initMenu() {
    QObject *rootObject = engine->rootObjects().first();

    QObject::connect(rootObject, SIGNAL(initConfig()), this, SLOT(initConfig()));
    QObject::connect(rootObject, SIGNAL(initMain()), this, SLOT(initMain()));
}

void WindowController::initConfig() {
    QObject *rootObject = engine->rootObjects().first()->findChild<QObject*>("configWindow");
    ConfigController *controller = ConfigController::getInstance();

    QList<QObject*> options;
    for (int i=0;i<controller->options.size(); i++) {
        options.append(controller->options[i]);
    }

    rootObject->setProperty("options", QVariant::fromValue(options));

    QList<AxisConfigOption*> axisOptions = controller->getAxisOptions();
    QList<QObject*> qAxisOptions;
    for (int i=0;i<axisOptions.size(); i++) {
        qAxisOptions.append(axisOptions[i]);
    }
    rootObject->setProperty("axisOptions", QVariant::fromValue(qAxisOptions));

    QList<ButtonConfigOption*> buttonOptions = controller->getButtonOptions();
    QList<QObject*> qButtonOptions;
    for (int i=0;i<buttonOptions.size(); i++) {
        qButtonOptions.append(buttonOptions[i]);
    }
    rootObject->setProperty("buttonOptions", QVariant::fromValue(qButtonOptions));

    rootObject->setProperty("count", QJoysticks::getInstance()->count());

    QObject::connect(rootObject, SIGNAL(configButtonSignal(int)), controller, SLOT(configButton(int)));
    QObject::connect(controller, SIGNAL(configDone()), rootObject, SIGNAL(configDone()));
}

void WindowController::initMain() {
    QObject *rootObject = engine->rootObjects().first()->findChild<QObject*>("mainWindow");
    ConfigController *controller = ConfigController::getInstance();

    QList<QObject*> objects;
    objects.append(new QMotor(new Motor(0), controller->upOption, controller->downOption));

    rootObject->setProperty("motorsModel", QVariant::fromValue(objects));
}
