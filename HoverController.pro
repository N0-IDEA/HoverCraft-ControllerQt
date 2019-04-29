#-------------------------------------------------
#
# Project created by QtCreator 2019-02-14T20:43:07
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

QT += quick
QT += quickwidgets
QT += quickcontrols2
QT += sql

TARGET = HoverController
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

CONFIG += c++11

SOURCES += \
        main.cpp \
    formmotor.cpp \
    controller/Motor.cpp \
    controller/Serial.cpp \
    formserial.cpp \
    configController/configcontroller.cpp \
    configController/configoption.cpp \
    qcontrollers/qmotor.cpp \
    configController/buttonconfigoption.cpp \
    configController/axisconfigoption.cpp \
    dbmanager.cpp \
    configController/perfil.cpp \
    controller/rf.cpp \
    qcontrollers/motorcontroller.cpp \
    qcontrollers/qservo.cpp
    qcontrollers/windowcontroller.cpp

HEADERS += \
    formmotor.h \
    controller/Motor.h \
    controller/Serial.h \
    formserial.h \
    main.h \
    configController/configcontroller.h \
    configController/configoption.h \
    qcontrollers/qmotor.h \
    configController/buttonconfigoption.h \
    configController/axisconfigoption.h \
    dbmanager.h \
    configController/perfil.h \
    controller/rf.h \
    qcontrollers/motorcontroller.h \
    qcontrollers/qservo.h
    qcontrollers/windowcontroller.h

FORMS += \
        mainwindow.ui \
    formmotor.ui \
    formserial.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    Motor.qml \
    IconGaugeStyle.qml \
    MotorGaugeStyle.qml \
    configController/configUI.qml

RESOURCES += \
    hovercontroller.qrc

LIBS += -lrf24

include ($$PWD/../../libs/QJoysticks/QJoysticks.pri)
