#include "rf.h"

#include <qdebug.h>

RF::RF()
{

}

void RF::connect()
{
    radio.begin();
    radio.enableAckPayload();
    radio.enableDynamicPayloads();

    if ( !radioNumber )    {
        radio.openWritingPipe(addresses[0]);
        radio.openReadingPipe(1,addresses[1]);
    }else{
        radio.openWritingPipe(addresses[1]);
        radio.openReadingPipe(1,addresses[0]);
    }
    //radio.startListening();
}

bool RF::write(void *buf, uint8_t len) {
    return radio.write(buf, len);
    //return true;
}

int RF::read(void *buf, uint8_t len) {
    while(true) {
        if(radio.write(buf, len)) {
            if(radio.available()) {
                int temp[2];
                radio.read(&temp, 2);
                if (temp[0] == temp[1])
                    return temp[0];
            }
        }
    }
}

