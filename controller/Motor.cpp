//
// Created by fquintana on 1/02/19.
//

#include "Motor.h"
#include "main.h"

void Motor::update() {

    char tempArray[4];

    tempArray[0] = id;
    tempArray[1] = 0x3A;
    tempArray[2] = potencia;
    tempArray[3] = 0x0A;

    error = !serial.send((char *) &tempArray, 4);

    if(!error)
        ultimaPotencia = potencia;

};
