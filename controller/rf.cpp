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
}
