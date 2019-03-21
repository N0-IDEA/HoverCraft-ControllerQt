#include "mainwindow.h"
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
#include <qcontrollers/qmotor.h>

Serial serial;
Motor timon(90);
void initConfig(QQmlApplicationEngine *engine);
void initTest(QQmlApplicationEngine *engine);
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QApplication::setFont(QFont("audiowide"));
    QJoysticks *instance = QJoysticks::getInstance();
    instance->setVirtualJoystickEnabled(true);

     QQmlApplicationEngine engine;
     engine.load(QUrl("qrc:/menu/Menu.qml"));
     initConfig(&engine);

   /* QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/configController/configUI.qml"));
    initConfig(&engine);*/

 /*  QQmlApplicationEngine engine1;
    engine1.load(QUrl("qrc:/Main.qml"));
    initTest(&engine1);*/

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
    ConfigController *controller = ConfigController::getInstance();

    QList<QObject*> objects;
        objects.append(new QMotor(new Motor(0), controller->upOption, controller->downOption));

    rootObject->setProperty("motorsModel", QVariant::fromValue(objects[0]));
}

void refresh() {

    /*QList<QObject*> objects;
    for (int i=0;i<controller.options.size(); i++) {
        objects.append(controller.options[i]);
    }


    engine.rootContext()->setContextProperty("myModel", QVariant::fromValue(objects));*/
}
