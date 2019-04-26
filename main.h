#ifndef MAIN_H
#define MAIN_H

#include "dbmanager.h"

#include <controller/Motor.h>
#include <controller/Serial.h>
#include <controller/rf.h>

#include <qcontrollers/qservo.h>

extern RF rf;
extern Serial serial;
extern DbManager dbManager;
extern Perfil* perfil;

#endif // MAIN_H
