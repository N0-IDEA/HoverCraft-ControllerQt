#include "formserial.h"
#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "main.h"
#include <QQuickItem>
#include <QQuickView>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->widgetMIzquierdo->setMotor(Motor(0), "MotorIzquierdo");
    ui->widgetMDerecho->setMotor(Motor(1), "MotorDerecho");
    ui->widgetMAtras->setMotor(Motor(2), "Motor Atras");
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_sendButton_clicked()
{
}

void MainWindow::on_actionSerial_triggered()
{
    FormSerial *serialDialog = new FormSerial(this);
    serialDialog->exec();
}

void MainWindow::on_izqButton_clicked()
{
    timon.potencia = 45;
    timon.update();
}

void MainWindow::on_middleButton_clicked()
{
    timon.potencia = 90;
    timon.update();
}

void MainWindow::on_derButton_clicked()
{
    timon.potencia = 135;
    timon.update();
}
