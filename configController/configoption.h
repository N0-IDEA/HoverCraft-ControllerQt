#ifndef CONFIGOPTION_H
#define CONFIGOPTION_H

#include <QObject>

class ConfigOption : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString option READ option)
    Q_PROPERTY(int idButton READ idButton NOTIFY idButtonChanged)
    Q_PROPERTY(int idGamepad READ idGamepad NOTIFY idGamepadChanged)
public:
    ConfigOption(QString option) : ConfigOption(option, 0, 0)  {
    }
    ConfigOption(QString option, int idButton,int idGamepad) : ConfigOption() {
        this->m_option = option;
        this->m_idButton = idButton;
        this->m_idGamepad = idGamepad;
    }
    explicit ConfigOption(QObject *parent = nullptr);

    QString option() const {
        return this->m_option;
    }
    int idButton() const {
        return this->m_idButton;
    }
    int idGamepad() const {
        return this->m_idGamepad;
    }

    void setIdButton(int);
    void setIdGamepad(int);

    QString m_option;
    int m_idButton;
    int m_idGamepad;

    virtual bool isActive() {
        return false;
    }
    virtual void config() {
        return;
    }
signals:
    void idButtonChanged();
    void idGamepadChanged();
public slots:
};

#endif // CONFIGOPTION_H
