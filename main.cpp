#include "main.h"
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQuickView>
#include <QQuickItem>
#include <QObject>
#include <QList>
#include <QVariant>
#include <QQmlContext>
#include <configController/configcontroller.h>
#include <qcontrollers/motorcontroller.h>
#include <qcontrollers/qmotor.h>
#include <qcontrollers/windowcontroller.h>

Serial serial;
RF rf;
DbManager dbManager("test.db");
Perfil* perfil;
void initConfig(QQmlApplicationEngine *engine);
void initTest(QQmlApplicationEngine *engine);
int main(int argc, char *argv[])
{
    //rf.connect();
    QApplication a(argc, argv);
    QApplication::setFont(QFont("audiowide"));
    QJoysticks *instance = QJoysticks::getInstance();
    instance->setVirtualJoystickEnabled(true);

    perfil = dbManager.createPerfil("PRUEBA");

    if(!dbManager.loadOptions(perfil->id))
        dbManager.createOptions(perfil->id);
    QQmlApplicationEngine engine;

    engine.load(QUrl("qrc:/configController/configUI.qml"));
    initConfig(&engine);
     QQmlApplicationEngine engine;
     engine.load(QUrl("qrc:/menu/Menu.qml"));
     WindowController *controller = new WindowController(&engine);
     controller->initMenu();

    QQmlApplicationEngine engine1;
    engine1.load(QUrl("qrc:/Main.qml"));

    initTest(&engine1);

    DbManager manager("test.db");

    return a.exec();
}

void initConfig(QQmlApplicationEngine *engine) {
    QObject *rootObject = engine->rootObjects().first();
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

    QObject::connect(rootObject, SIGNAL(configButtonSignal(int)), controller, SLOT(configButton(int)));
    QObject::connect(controller, SIGNAL(configDone()), rootObject, SIGNAL(configDone()));
}

void initTest(QQmlApplicationEngine *engine) {
    QObject *rootObject = engine->rootObjects().first();

    MotorController *motorController = MotorController::getInstance();
    QList<QMotor*> motors = motorController->motors;
    QList<QObject*> objects;
        for (int i=0;i<motors.size(); i++) {
            objects.append(motors[i]);
        }
    rootObject->setProperty("motorsModel", QVariant::fromValue(objects));
}

void refresh() {

    /*QList<QObject*> objects;
    for (int i=0;i<controller.options.size(); i++) {
        objects.append(controller.options[i]);
    }


    engine.rootContext()->setContextProperty("myModel", QVariant::fromValue(objects));*/
}
