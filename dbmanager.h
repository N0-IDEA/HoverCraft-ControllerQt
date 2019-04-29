#ifndef DBMANAGER_H
#define DBMANAGER_H

#include <QSqlDatabase>
#include <qstring.h>

#include <configController/configoption.h>
#include <configController/perfil.h>
#define SQLITE "QSQLITE"


class DbManager
{
public:
    DbManager(const QString &path);
    QList<Perfil> getPerfiles();
    void createOptions(int idPerfil);
    bool loadOptions(int idPerfil);
    Perfil *getPerfil(char *nombre);
    Perfil *createPerfil(char *nombre);
    void saveOption(int idPerfil, int option);
private:
    QSqlDatabase m_database;
};

#endif // DBMANAGER_H
