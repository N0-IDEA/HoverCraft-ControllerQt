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
#include <qcontrollers/windowcontroller.h>

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
     WindowController *controller = new WindowController(&engine);
     controller->initMenu();

    return a.exec();
}

void refresh() {

    /*QList<QObject*> objects;
    for (int i=0;i<controller.options.size(); i++) {
        objects.append(controller.options[i]);
    }


    engine.rootContext()->setContextProperty("myModel", QVariant::fromValue(objects));*/
}
