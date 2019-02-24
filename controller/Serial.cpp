//
// Created by fquintana on 1/02/19.
//

#include <termios.h>
#include <fcntl.h>
#include <zconf.h>
#include <cstring>
#include "Serial.h"


void Serial::connect(char * device) {

    struct termios toptions;

    fd = open(device, O_RDWR | O_NOCTTY | O_NDELAY);

    if(fd == -1) {
        error = true;
        return;
    }

    /* get current serial port settings */
    tcgetattr(fd, &toptions);

    /* 9600 bauds */
    cfsetispeed(&toptions, B9600);
    cfsetospeed(&toptions, B9600);

    // 8N1
    toptions.c_cflag &= ~PARENB;
    toptions.c_cflag &= ~CSTOPB;
    toptions.c_cflag &= ~CSIZE;
    toptions.c_cflag |= CS8;

    // no flow control
    toptions.c_cflag &= ~CRTSCTS;

    // turn on READ & ignore ctrl lines
    toptions.c_cflag |= CREAD | CLOCAL;

    // turn off s/w flow ctrl
    toptions.c_iflag &= ~(IXON | IXOFF | IXANY);

    // RAW
    toptions.c_lflag &= ~(ICANON | ECHO | ECHOE | ISIG);

    // RAW
    toptions.c_oflag &= ~OPOST;

    tcsetattr(fd, TCSANOW, &toptions);

    sleep(20);

    status = SERIAL_CONNECTED;
    error = false;

}

void Serial::disconnect() {
    close(fd);
    status = SERIAL_DISCONNECTED;
}

bool Serial::send(char *pointer, int num) {

    if(status != SERIAL_CONNECTED)
        return false;

    write(fd, pointer, num);
    char temp[num];
    return internalRead(temp, num);
}

bool Serial::internalRead(char *buffer, int num) {
    int inbuf = 0;
    bool done = false;

    struct timeval start, now;

    gettimeofday (&start, NULL);
    while (!done)
    {
        int bytesRead = read(fd, &buffer[inbuf], num - inbuf);
        if (bytesRead < 0)
        {
            //printf("Oh dear, something went wrong with read()! %s\n %i\n", strerror(errno), inbuf);
            //continue;
        }
        if (bytesRead <= 0)
        {
            gettimeofday (&now, NULL);
            if ((now.tv_sec  - start.tv_sec) * 1000000 +
                now.tv_usec - start.tv_usec > TIMEOUT)
            {
                //TIMEOUT
                printf("TIMEOUT");
                return false;
            }
            //sleep(1);
            continue;
        }
        inbuf += bytesRead;
        if (inbuf >= num)
            done = true;
    }
    return true;
}

/*
bool Serial::internalSend(char byte) {

    char temp = NULL;

    if(write(fd, &byte, 1) != -1)
        read(fd, &temp, 1);

    return temp == byte;
}*/