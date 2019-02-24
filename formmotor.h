#ifndef FORMMOTOR_H
#define FORMMOTOR_H

#include <QWidget>

#include <controller/Motor.h>

namespace Ui {
class FormMotor;
}

class FormMotor : public QWidget
{
    Q_OBJECT

public:
    explicit FormMotor(QWidget *parent = nullptr);
    ~FormMotor();
    void setMotor(Motor motor, char *motorName);

private slots:
    void on_sendButton_clicked();

    void on_valueSelector_editingFinished();

private:
    Ui::FormMotor *ui;
    Motor motor = Motor(0);
    void updateMotor();
};

#endif // FORMMOTOR_H
