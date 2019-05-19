#ifndef QPERFIL_H
#define QPERFIL_H

#include <QObject>

class QPerfil : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name)
public:
    explicit QPerfil(QObject *parent = nullptr);
    QString name() const {
        return m_name;
    }
    QString m_name;
    int id;

    QPerfil(QString name, int id);
signals:

public slots:
};

#endif // QPERFIL_H
