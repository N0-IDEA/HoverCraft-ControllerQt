//
// Created by fquintana on 1/02/19.
//

#ifndef MULTIPLESLUCES_SERIAL_H
#define MULTIPLESLUCES_SERIAL_H

#define SERIAL_CONNECTED 1
#define SERIAL_DISCONNECTED 0
//10 SEGUNDOS (MICROSEGUNDOS)
#define TIMEOUT 10000000

#include <errno.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>

class Serial {
    int fd;
    bool internalSend(char byte);
public:
    //CLOSED 0
    //OPENED 1
    int status = 0;
    bool error = 0;
    void connect(char * device);
    void disconnect();
    bool send(char *pointer, int num);
    bool internalRead(char *buffer, int num);
};


#endif //MULTIPLESLUCES_SERIAL_H
