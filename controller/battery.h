#ifndef BATTERY_H
#define BATTERY_H


class Battery
{
public:
    bool error;
    int cells[3];
    Battery();
    void getInfo();
};

#endif // BATTERY_H
