#include "TpTimeOut.h"

TpTimeOut::TpTimeOut(const QString &configPath, QObject *parent)
    : QObject(parent),
      m_settings(configPath, QSettings::IniFormat)
{
    reload();  // 构造时立即读取一次
}

int TpTimeOut::tpTimeout() const
{
    return m_tpTimeout;
}

void TpTimeOut::reload()
{
    int newValue = m_settings.value("DisplayTimes/Tptime", 60).toInt();

    if (newValue != m_tpTimeout) {
        m_tpTimeout = newValue;
        emit tpTimeoutChanged();
    }
}