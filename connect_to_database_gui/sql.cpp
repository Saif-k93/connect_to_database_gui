#include "sql.h"

Sql::Sql(QObject *parent)
    : QObject{parent}
{

}

bool Sql::connect(QString plugin, QString database, QString hostname, int port, QString username, QString password)
{
    if(!db.isOpen()) {
        db = QSqlDatabase::addDatabase(plugin);
        db.setDatabaseName(database);
        db.setHostName(hostname);
        db.setPort(port);
        db.setUserName(username);
        db.setPassword(password);
    }

    bool ok = db.open();

    if(!ok) {
        m_error = db.lastError().text();
        emit errorChanged();

        db.removeDatabase(database);
        db.close();
        return false;
    }
    return true;
}

void Sql::close()
{
    db.close();
}

void Sql::run(QString table)
{
    QSqlQuery q(db);

    if(!q.exec("SELECT * FROM " + table)){
        qInfo() << "Database Error: >> " << db.lastError().text();
        qInfo() << "Query Error: >> " << q.lastError().text();
        return;
    }

    if (!m_data.isEmpty())
        m_data.clear();

    QSqlRecord columns = q.record();

    m_data.append("------------------------------");
    m_data.append("\n");
    m_data.append("Number Of Rows: ");
    m_data.append(QByteArray::number(q.size()));
    m_data.append("\n");
    m_data.append("------------------------------");
    m_data.append("\n");
    m_data.append("Number Of Columns: ");
    m_data.append(QByteArray::number(columns.count()));
    m_data.append("\n\n");

    while(q.next()) {

        for(int x{0}; x < columns.count(); x++)
        {
            m_data.append("'");
            m_data.append(q.value(x).toString().toLatin1());
            m_data.append("'");

        }
        m_data.append("\n");
        m_data.append("------------------------------------------------------------");
        m_data.append("\n");
    }
    emit dataChanged();
}

void Sql::clear()
{
    m_data.clear();
}
