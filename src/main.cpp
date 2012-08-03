/*
* Copyright (C) 2012 J-P Nurmi <jpnurmi@gmail.com>
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*/
#include <QtGui>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "networkaccessmanager.h"
#include "meegographicssystemimageprovider.h"

static bool removeDir(const QDir &dir)
{
    bool result = true;
    if (dir.exists()) {
        QFileInfoList entries = dir.entryInfoList(QDir::NoDotAndDotDot | QDir::System | QDir::Hidden  | QDir::AllDirs | QDir::Files);
        foreach (const QFileInfo &info, entries) {
            if (info.isDir())
                result &= removeDir(QDir(info.absoluteFilePath()));
            else
                result &= QFile::remove(info.absoluteFilePath());
        }
        QDir parent(dir);
        if (parent.cdUp())
            parent.rmdir(dir.dirName());
    }
    return result;
}

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication::setApplicationName("MeeTeeVee");
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QPixmapCache::setCacheLimit(20 * 1024);

    QmlApplicationViewer viewer;

    QString cachePath = QDesktopServices::storageLocation(QDesktopServices::CacheLocation);
    NetworkAccessManagerFactory *factory = new NetworkAccessManagerFactory(cachePath);
    viewer.engine()->setNetworkAccessManagerFactory(factory);

    QLatin1String imagePath("/opt/MeeTeeVee/qml/MeeTeeVee/images");
    MeeGoGraphicsSystemImageProvider *provider = new MeeGoGraphicsSystemImageProvider(imagePath);
    viewer.engine()->addImageProvider("MeeTeeVee", provider);

    if (app->arguments().contains("-reset")) {
        qDebug() << "MeeTeeVee reset...";
        qDebug() << "  -> Network disk cache:" << (removeDir(cachePath) ? "OK" : "FAIL!") << qPrintable("("+cachePath+")");
        qDebug() << "  -> QML offline storage:" << (removeDir(viewer.engine()->offlineStoragePath()) ? "OK" : "FAIL!") << qPrintable("("+viewer.engine()->offlineStoragePath()+")");
    }

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/MeeTeeVee/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
