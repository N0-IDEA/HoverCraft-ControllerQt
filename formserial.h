#ifndef FORMSERIAL_H
#define FORMSERIAL_H

#include <QDialog>
#include <ui_formserial.h>

namespace Ui {
class FormSerial;
}

class FormSerial  : public QDialog, public Ui::FormSerial {
    Q_OBJECT

public:
    FormSerial(QWidget *parent = nullptr);
private slots:
    void on_openButton_clicked();
    void on_closeButton_clicked();
};

#endif // FORMSERIAL_H
