#include "cppdata.h"
#include<QDebug>

extern uint16_t u16PageValue;
extern uint8_t u8EndTestCmd;

CppData::CppData(QObject *parent)
{

}

int CppData::getUartValue()
{
//    qDebug()<<"get uart value";
    int mValue = 0;

    mValue = u16PageValue;
    return mValue;
}

void CppData::qmlValue(bool defaultPage)
{
//    qDebug()<<"defaultPage"<<defaultPage;
    u8EndTestCmd = defaultPage;
}
