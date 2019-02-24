#include "configoption.h"

ConfigOption::ConfigOption(QObject *parent) : QObject(parent)
{

}

void ConfigOption::setIdButton(int id) {
    if (id != m_idButton) {
        m_idButton = id;
        emit idButtonChanged();
    }
}
void ConfigOption::setIdGamepad(int id) {
    if (id != m_idGamepad) {
        m_idGamepad = id;
        emit idGamepadChanged();
    }
}
