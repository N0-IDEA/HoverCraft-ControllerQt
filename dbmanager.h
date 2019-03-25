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
    void loadOptions(int idPerfil);
    void createOptions(int idPerfil);
    void saveOptions(int idPerfil);
private:
    QSqlDatabase m_database;
};

#endif // DBMANAGER_H
