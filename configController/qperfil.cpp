#include "qperfil.h"

QPerfil::QPerfil(QString name, int id) : QPerfil()
{
    this->m_name = name;
    this->id = id;
}


QPerfil::QPerfil(QObject *parent) : QObject(parent)
{

}
