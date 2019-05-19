#ifndef DBMANAGER_H
#define DBMANAGER_H

#include <QSqlDatabase>
#include <qstring.h>

#include <configController/configoption.h>
#include <configController/qperfil.h>
#define SQLITE "QSQLITE"


class DbManager
{
public:
    DbManager(const QString &path);
    QList<QPerfil *> getPerfiles();
    void createOptions(int idPerfil);
    bool loadOptions(int idPerfil);
    QPerfil *getPerfil(char *nombre);
    QPerfil *createPerfil(char *nombre);
    void saveOption(int idPerfil, int option);
    bool deleProfile(char *nombre);
private:
    QSqlDatabase m_database;
};

#endif // DBMANAGER_H
