#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:

    void on_sendButton_clicked();

    void on_actionSerial_triggered();

    void on_izqButton_clicked();

    void on_middleButton_clicked();

    void on_derButton_clicked();

private:
    Ui::MainWindow *ui;
};

#endif // MAINWINDOW_H
