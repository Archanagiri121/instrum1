#ifndef CONFIGREADER_H
#define CONFIGREADER_H

#include <QObject>
#include <QString>
#include <QSettings>

class ConfigReader : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString imagePath READ imagePath NOTIFY imagePathChanged)

public:
    explicit ConfigReader(QObject *parent = nullptr);

    QString imagePath() const;

signals:
    void imagePathChanged();

private:
    QString m_imagePath;
    void readConfig();
    void createDefaultConfig(const QString &filePath);
};

#endif
