#include <QGuiApplication>
#include <QApplication>
#include <QQuickView>
#include <QQmlApplicationEngine>
#include "cppdata.h"

extern void* threadtime(void* arg);
extern void* threaduart(void* arg);

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<CppData>("CppData",1,0,"CppToQmlData");

    int ret = -1;
    pthread_t tid1, tid2;

    ret = pthread_create(&tid1, NULL, threadtime, NULL);
    if(ret == 0)
    {
        printf("create thread successfully!\n");
        ret = pthread_detach(tid1);
        if(ret == 0)
        {
            printf("thread detach successfully!\n");
        }
    }

    ret = pthread_create(&tid2, NULL, threaduart, NULL);
    if(ret == 0)
    {
        printf("create thread successfully!\n");
        ret = pthread_detach(tid2);
        if(ret == 0)
        {
            printf("thread detach successfully!\n");
        }
    }

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("E29_EOLTest", "Main");

    return app.exec();
}
