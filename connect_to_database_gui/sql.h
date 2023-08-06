#ifndef SQL_H
#define SQL_H

#include <QObject>
#include <QVariant>
#include <QString>
#include <QDebug>
#include <QByteArray>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>

class Sql : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString error MEMBER m_error NOTIFY errorChanged FINAL)
    Q_PROPERTY(QByteArray data MEMBER m_data NOTIFY dataChanged FINAL)
public:
    explicit Sql(QObject *parent = nullptr);

    Q_INVOKABLE bool connect(QString plugin, QString database, QString hostname, int port, QString username, QString password);
    Q_INVOKABLE void close();
    Q_INVOKABLE void run(QString table);
    Q_INVOKABLE void clear();
signals:
    void errorChanged();
    void dataChanged();

private:
    QSqlDatabase db;
    QString m_error;
    QByteArray m_data;

};

#endif // SQL_H
