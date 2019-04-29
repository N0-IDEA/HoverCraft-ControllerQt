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
        query.exec("CREATE TABLE IF NOT EXISTS OPCIONES ( `idGamepad` INTEGER NOT NULL, `idButton` INTEGER NOT NULL, `option` INTEGER NOT NULL, `value` REAL, `idPerfil` INTEGER, PRIMARY KEY(`option`,`idPerfil`), FOREIGN KEY(`idPerfil`) REFERENCES OPCIONES(perfil_id) );"
                   );
    }
}

QList<Perfil> DbManager::getPerfiles() {
    QList<Perfil> perfiles;
    QSqlQuery query("SELECT * FROM PERFILES");
    query.exec();
    while (query.next()) {
        int id = query.value(0).toInt();
        QString nombre = query.value(1).toString();
        perfiles.append(Perfil(nombre, id));
    }
    return perfiles;
}

Perfil* DbManager::getPerfil(char* nombre) {
    QSqlQuery query;
    query.prepare("SELECT * FROM PERFILES WHERE nombre = :nombre");
    query.bindValue(":nombre", nombre);
    query.exec();
    if (query.next()) {
        int id = query.value(0).toInt();
        QString nombre = query.value(1).toString();
        return new Perfil(nombre, id);
    }
    return nullptr;
}


Perfil* DbManager::createPerfil(char* nombre) {
        Perfil* perfil = getPerfil(nombre);
        if (perfil == nullptr) {
            QSqlQuery query;
            query.prepare("INSERT INTO PERFILES (nombre) "
                          "VALUES (:nombre)");
            query.bindValue(":nombre", nombre);
            query.exec();
            perfil = getPerfil(nombre);
        }
        return perfil;
}

bool DbManager::loadOptions(int idPerfil) {
    QSqlQuery query;
    query.prepare("SELECT * FROM OPCIONES WHERE idPerfil = :id");
    query.bindValue(":id", idPerfil);
    query.exec();
    if(!query.next() && query.size() != ConfigController::getInstance()->options.size())
        return false;
    do {
        int id = query.value(0).toInt();
        int idButton = query.value(1).toInt();
        int option = query.value(2).toInt();
        qreal value = query.value(3).toReal();
        ConfigOption *configOption = ConfigController::getInstance()->options[option];
        configOption->setIdGamepad(id);
        configOption->setIdButton(idButton);
        configOption->setValue(value);
    } while (query.next());

    return true;
}

void DbManager::createOptions(int idPerfil) {
    for (int option = 0; option<ConfigController::getInstance()->options.size(); option++) {
        QSqlQuery querySelect;
        querySelect.prepare("SELECT * FROM OPCIONES WHERE idPerfil = :id AND option = :option");
        querySelect.bindValue(":id", idPerfil);
        querySelect.bindValue(":option", option);
        querySelect.exec();
        if (!querySelect.next()) {
            ConfigOption *configOption = ConfigController::getInstance()->options[option];
            QSqlQuery query;
            query.prepare("INSERT INTO OPCIONES (idGamepad, idButton, option, value, idPerfil) "
                          "VALUES (:idGamepad, :idButton, :option, :value, :idPerfil)");
            query.bindValue(":idGamepad", configOption->idGamepad());
            query.bindValue(":idButton", configOption->idButton());
            query.bindValue(":option", option);
            query.bindValue(":value", configOption->value());
            query.bindValue(":idPerfil", idPerfil);
            query.exec();
        }
    }

}

void DbManager::saveOption(int idPerfil, int option) {
    ConfigOption *configOption = ConfigController::getInstance()->options[option];
    QSqlQuery query;
    query.prepare("UPDATE OPCIONES SET idGamepad = :idGamepad, idButton = :idButton, value = :value "
                  "WHERE option = :option AND idPerfil = :idPerfil");
    query.bindValue(":idGamepad", configOption->idGamepad());
    query.bindValue(":idButton", configOption->idButton());
    query.bindValue(":option", option);
    query.bindValue(":value", configOption->value());
    query.bindValue(":idPerfil", idPerfil);
    query.exec();
}


