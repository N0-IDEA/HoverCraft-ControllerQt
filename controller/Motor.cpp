//
// Created by fquintana on 1/02/19.
//

#include "Motor.h"
#include "main.h"

#include <qdebug.h>

char getByte(int posByte, int value) {
    return (value >>  (8 * posByte)) & 0xff;
}

void Motor::update() {

    if(ultimaPotencia == potencia && !error)
        return;

    char tempArray[4];

    tempArray[0] = 0;
    tempArray[1] = id;
    tempArray[2] = getByte(1, potencia);
    tempArray[3] = getByte(0, potencia);

    this->error = !rf.write(tempArray, 4);

    if(!error) {
        ultimaPotencia = potencia;
    }
};
