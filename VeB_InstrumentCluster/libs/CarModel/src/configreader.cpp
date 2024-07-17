#include "include/configreader.h"
#include <QFile>
#include <QCoreApplication>
#include <QDebug>
#include <QDir>

ConfigReader::ConfigReader(QObject *parent) : QObject(parent) {
    readConfig();
}

QString ConfigReader::imagePath() const {
    return m_imagePath;
}

void ConfigReader::readConfig() {

    QString filePath = QCoreApplication::applicationDirPath() + "//config.ini";

    // Check if the config.ini file exists
    QSettings settings(filePath, QSettings::IniFormat);

    if (!settings.contains("SplashScreen/ImagePath")) {
        // If the file does not contain the required keys, create default configuration
        qDebug() << "config.ini not found or incomplete. Creating default configuration.";
        createDefaultConfig(filePath);
    }

    // Read the config.ini file
    m_imagePath = settings.value("SplashScreen/ImagePath").toString();

    emit imagePathChanged();
}

void ConfigReader::createDefaultConfig(const QString &filePath) {
    QSettings settings(filePath, QSettings::IniFormat);

    // Set the default values for the configuration
    settings.beginGroup("SplashScreen");
    settings.setValue("ImagePath", "Image/splashScreenLogo.png");
    settings.endGroup();

    // Verify if the file was successfully written
    if (settings.status() == QSettings::NoError) {
        qDebug() << "Default configuration created.";
    } else {
        qWarning() << "Failed to create default configuration!";
    }
}
