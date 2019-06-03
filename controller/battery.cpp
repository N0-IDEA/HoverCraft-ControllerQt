#include "battery.h"
#include "main.h"

Battery::Battery()
{

}

void Battery::getInfo() {
    for (int i=0; i<3; i++) {
        int tempArray[2];
        tempArray[0] = 1;
        tempArray[1] = i;
        this->error = true;
        cells[i] = rf.read(tempArray, 2);
    }
}
