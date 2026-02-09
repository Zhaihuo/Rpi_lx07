#include <QGuiApplication>
#include <QApplication>
#include <QQuickView>
#include <QQmlApplicationEngine>
#include "cppdata.h"

#include <QQmlContext>
#include "TpTimeOut.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // QString configPath = "/media/wenlun/thinkplus/app/Prototype/TouchAreaTest_4.0_Touch_addtimeout/timeout.ini";//test
    QString configPath = "/boot/firmware/tptouch/timeout.ini";
    // QString configPath = "/app/tptouch/timeout.ini";//rootfs
    TpTimeOut *config = new TpTimeOut(configPath, &app);

    // 注册 C++ 类型给 QML 使用
    qmlRegisterType<CppData>("CppData", 1, 0, "CppToQmlData");

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("TpTimeOut", config);

    // 连接 engine 创建失败时的退出逻辑
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() { QCoreApplication::exit(-1); },
                     Qt::QueuedConnection);

    engine.loadFromModule("TouchAreaTest", "Main");

    return app.exec();
}
