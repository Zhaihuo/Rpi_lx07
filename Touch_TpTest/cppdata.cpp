#include "cppdata.h"
#include<QDebug>

CppData::CppData(QObject *parent)
{

}

int CppData::getUartValue()
{
    // qDebug()<<"get uart value";
    int mValue = 0;
    return mValue;
}

void CppData::qmlValue(bool defaultPage)
{
    qDebug()<<"defaultPage"<<defaultPage;
}
