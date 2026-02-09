#ifndef TPTIMEOUT_H
#define TPTIMEOUT_H

#include <QObject>
#include <QSettings>

class TpTimeOut : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int tpTimeout READ tpTimeout NOTIFY tpTimeoutChanged)

public:
    explicit TpTimeOut(const QString &configPath, QObject *parent = nullptr);

    int tpTimeout() const;

    // 允许 QML 或其他地方手动重新加载配置
    Q_INVOKABLE void reload();

signals:
    void tpTimeoutChanged();

private:
    QSettings m_settings;
    int m_tpTimeout = 3;  // 默认值3秒,若3s后依旧读不到文件的值，则用默认值
};

#endif // TPTIMEOUT_H