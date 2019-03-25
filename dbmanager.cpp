#include "dbmanager.h"

#include <QSqlQuery>
#include <QVariant>

#include <configController/configcontroller.h>
#include <configController/configoption.h>
#include <configController/perfil.h>
DbManager::DbManager(const QString& path)
{
    if(QSqlDatabase::isDriverAvailable(SQLITE)) {
        m_database = QSqlDatabase::addDatabase(SQLITE);
        m_database.setDatabaseName(path);
        m_database.open();

        QSqlQuery query;
        query.exec("CREATE TABLE IF NOT EXISTS PERFILES ("
                   "perfil_id INTEGER PRIMARY KEY,"
                   "nombre TEXT NOT NULL"
                   ");"
                   );
        query.exec("CREATE TABLE IF NOT EXISTS OPCIONES ( `idGamepad` INTEGER NOT NULL, `idButton` INTEGER NOT NULL, `option` INTEGER NOT NULL, `value` REAL, `idPerfil` INTEGER, PRIMARY KEY(`idGamepad`,`idButton`), FOREIGN KEY(`idPerfil`) REFERENCES OPCIONES(perfil_id) );"
                   );
    }
}

QList<Perfil> DbManager::getPerfiles() {
    QList<Perfil> perfiles;
    QSqlQuery query("SELECT * FROM PERFILES");
    while (query.next()) {
        int id = query.value(0).toInt();
        QString nombre = query.value(1).toString();
        perfiles.append(Perfil(nombre, id));
    }
    return perfiles;
}

void DbManager::loadOptions(int idPerfil) {
    QSqlQuery query("SELECT * FROM OPCIONES WHERE idPerfil = :id");
    query.bindValue(":id", idPerfil);
    while (query.next()) {
        int id = query.value(0).toInt();
        int idButton = query.value(1).toInt();
        int option = query.value(2).toInt();
        qreal value = query.value(3).toReal();
        ConfigOption *configOption = ConfigController::getInstance()->options[option];
        configOption->setIdGamepad(id);
        configOption->setIdButton(idButton);
        configOption->setValue(value);
    }
}

void DbManager::createOptions(int idPerfil) {
    //QSqlQuery query("INSERT INTO ")
}

void DbManager::saveOptions(int idPerfil) {

}


