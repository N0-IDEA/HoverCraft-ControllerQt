//
// Created by fquintana on 1/02/19.
//

#ifndef MULTIPLESLUCES_MOTOR_H
#define MULTIPLESLUCES_MOTOR_H

class Motor {

public:
    int id;
    int potencia;
    int ultimaPotencia;
    bool error;

    Motor(int motorID) {
        id = motorID;
        potencia = 0;
        ultimaPotencia = 0;
        error = false;
    }

    void update();
};


#endif //MULTIPLESLUCES_MOTOR_H
