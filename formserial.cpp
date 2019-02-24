#include "formserial.h"
#include "ui_formserial.h"
#include "main.h"

FormSerial::FormSerial(QWidget *parent) : QDialog(parent)
{
    setupUi(this);
}

void FormSerial::on_openButton_clicked()
{
    serial.connect(this->portName->text().toLocal8Bit().data());

    if(serial.status == 1) {
        this->openButton->setEnabled(false);
        this->closeButton->setEnabled(true);
    }
}

void FormSerial::on_closeButton_clicked()
{
    serial.disconnect();

    this->openButton->setEnabled(true);
    this->closeButton->setEnabled(false);
}
