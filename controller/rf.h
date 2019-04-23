#ifndef RF_H
#define RF_H

#include <RF24/RF24.h>

class RF
{
public:
    RF();
    void connect();
    bool write(void *buf, uint8_t len);
private:
    RF24 radio = RF24(4,0);
    const int radioNumber = 1;
    const uint8_t addresses[2][6] = {"1Node","2Node"};
};

#endif // RF_H
