#include "formmotor.h"
#include "ui_formmotor.h"
#include <QQuickItem>
#include <QQuickView>

FormMotor::FormMotor(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::FormMotor)
{
    ui->setupUi(this);
    ui->quickWidget->setAttribute(Qt::WA_TranslucentBackground, true);
    ui->quickWidget->setAttribute(Qt::WA_AlwaysStackOnTop, true);
    ui->quickWidget->setClearColor(Qt::transparent);

    ui->quickWidget->rootObject()->setProperty("speedometerWidth", ui->quickWidget->width());
    ui->quickWidget->rootObject()->setProperty("speedometerHeight", ui->quickWidget->height());

    ui->error->setVisible(false);
}

void FormMotor::setMotor(Motor motor, char *motorName) {
    ui->MotorName->setText(motorName);
    this->motor = motor;
}

FormMotor::~FormMotor()
{
    delete ui;
}

void FormMotor::on_sendButton_clicked()
{
    this->updateMotor();
}

void FormMotor::updateMotor() {
    //ui->quickWidget->rootObject()->setProperty("ppm",ui->valueSelector->value());
    motor.potencia = ui->valueSelector->value();
    motor.update();
    ui->quickWidget->rootObject()->setProperty("ppm", motor.ultimaPotencia);
    ui->error->setVisible(motor.error);
}

void FormMotor::on_valueSelector_editingFinished()
{
     this->updateMotor();
}
