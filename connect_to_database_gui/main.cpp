#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "sql.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    qmlRegisterType<Sql>("sql.h", 1, 0, "Sql");

    engine.loadFromModule("connect_to_database_gui", "Main");


    return app.exec();
}
