#ifndef CPPDATA_H
#define CPPDATA_H

#include <QObject>

class CppData: public QObject
{
    Q_OBJECT
public:

    Q_INVOKABLE int getUartValue();
    Q_INVOKABLE void qmlValue(bool defaultPage);
    explicit CppData(QObject *parent = nullptr);
};

#endif // CPPDATA_H
