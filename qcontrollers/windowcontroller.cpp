#include "motorcontroller.h"
#include "windowcontroller.h"

#include <QComboBox>

WindowController::WindowController(QObject *parent) : QObject(parent)
{

}

void WindowController::initMenu() {
    QObject *rootObject = engine->rootObjects().first();

    QObject::connect(rootObject, SIGNAL(initConfig()), this, SLOT(initConfig()));
    QObject::connect(rootObject, SIGNAL(initMain()), this, SLOT(initMain()));
}

void WindowController::initConfig()     {
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

    updateProfiles();

    rootObject->setProperty("count", QJoysticks::getInstance()->count());

    QObject::connect(rootObject, SIGNAL(configButtonSignal(int)), controller, SLOT(configButton(int)));
    QObject::connect(controller, SIGNAL(configDone()), rootObject, SIGNAL(configDone()));

    QObject::connect(rootObject, SIGNAL(createProfileSignal(QString)), controller, SLOT(createProfile(QString)));
    QObject::connect(rootObject, SIGNAL(loadProfileSignal(QString)), controller, SLOT(loadPerfil(QString)));
    QObject::connect(rootObject, SIGNAL(deleteProfileSignal()), controller, SLOT(deleteProfile()));
}

void WindowController::updateProfiles(){
    QObject *rootObject = engine->rootObjects().first()->findChild<QObject*>("configWindow");

    QList<QPerfil*> perfiles = dbManager.getPerfiles();
    QList< QObject*> perfilesQ;

    for (int i=0;i<perfiles.size(); i++) {
        perfilesQ.append(perfiles[i]);//->name());
    }

    rootObject->setProperty("profile", QVariant::fromValue((QObject *)perfil));
    rootObject->setProperty("profiles", QVariant::fromValue(perfilesQ));
}

void WindowController::initMain() {
    QObject *rootObject = engine->rootObjects().first()->findChild<QObject*>("mainWindow");

    MotorController *motorController = MotorController::getInstance();
    QList<QMotor*> motors = motorController->motors;
    QList<QObject*> objects;
    for (int i=0;i<motors.size(); i++) {
        objects.append(motors[i]);
    }
    rootObject->setProperty("motorsModel", QVariant::fromValue(objects));

    MotorController *servoController = MotorController::getInstance();
    QList<QServo*> servos = servoController->servos;
    QList<QObject*> servoObjects;
    for (int i=0;i<servos.size(); i++) {
        servoObjects.append(servos[i]);
    }
    rootObject->setProperty("servosModel", QVariant::fromValue(servoObjects));
}

WindowController* WindowController::getInstance()
{
    static WindowController controller;
    return &controller;
}
