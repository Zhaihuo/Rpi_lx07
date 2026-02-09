#include <QGuiApplication>
#include <QApplication>
#include <QQuickView>
#include <QQmlApplicationEngine>
#include "cppdata.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<CppData>("CppData",1,0,"CppToQmlData");

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("TouchAreaTest", "Main");

    return app.exec();
}
