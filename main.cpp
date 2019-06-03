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
#include <camera/hovercamera.h>

Serial serial;
RF rf;
DbManager dbManager("test.db");
QPerfil* perfil;
void initConfig(QQmlApplicationEngine *engine);
void initTest(QQmlApplicationEngine *engine);
int main(int argc, char *argv[])
{
    rf.connect();
    QApplication a(argc, argv);
    a.setWindowIcon(QIcon(":/configController/icon.png"));
    QApplication::setFont(QFont("audiowide"));
    QJoysticks *instance = QJoysticks::getInstance();
    instance->setVirtualJoystickEnabled(true);
    ConfigController::getInstance()->loadPerfil(dbManager.getPerfiles()[0]->name());

    qmlRegisterType<HoverCameraFB>("HoverCameraPK",1,0,"HoverCamera");

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/menu/Menu.qml"));

    WindowController *controller = WindowController::getInstance();
    controller->setEngine(&engine);
    controller->initMenu();

    DbManager manager("test.db");

    return a.exec();
}
void refresh() {

    /*QList<QObject*> objects;
    for (int i=0;i<controller.options.size(); i++) {
        objects.append(controller.options[i]);
    }


    engine.rootContext()->setContextProperty("myModel", QVariant::fromValue(objects));*/
}
