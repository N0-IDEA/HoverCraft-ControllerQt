//
// Created by fquintana on 1/02/19.
//

#include "Motor.h"
#include "main.h"

char getByte(int posByte, int value) {
    return (value >>  (8 * posByte)) & 0xff;
}

void Motor::update() {

    char tempArray[4];

    tempArray[0] = id;
    tempArray[2] = getByte(1, potencia);
    tempArray[3] = getByte(0, potencia);

    error = !serial.send((char *) &tempArray, 3);

    if(!error)
        ultimaPotencia = potencia;

};
