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
#include <QtNetwork>
#include <QtDeclarative>
#include <QtMeeGoGraphicsSystemHelper>
#include "qmlapplicationviewer.h"

class NetworkAccessManager : public QNetworkAccessManager
{
public:
    NetworkAccessManager(QObject *parent) : QNetworkAccessManager(parent) { }

protected:
    virtual QNetworkReply *createRequest(Operation operation, const QNetworkRequest &request, QIODevice *outgoingData = 0)
    {
        QNetworkRequest cacheRequest(request);
        cacheRequest.setAttribute(QNetworkRequest::CacheLoadControlAttribute, QNetworkRequest::PreferCache);
        return QNetworkAccessManager::createRequest(operation, cacheRequest, outgoingData);
    }
};

class NetworkAccessManagerFactory : public QDeclarativeNetworkAccessManagerFactory
{
public:
    virtual QNetworkAccessManager *create(QObject *parent)
    {
        QNetworkAccessManager *nam = new NetworkAccessManager(parent);
        QNetworkDiskCache *cache = new QNetworkDiskCache(nam);
        cache->setCacheDirectory(QDesktopServices::storageLocation(QDesktopServices::CacheLocation));
        nam->setCache(cache);
        return nam;
    }
};

class BackgroundProvider : public QDeclarativeImageProvider
{
public:
    BackgroundProvider() : QDeclarativeImageProvider(Pixmap) { }

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
    {
        QPixmap pixmap;
        QImage image("/opt/MeeTeeVee/qml/MeeTeeVee/images/background.png");
        image = image.convertToFormat(QImage::Format_ARGB32_Premultiplied);
        if (QMeeGoGraphicsSystemHelper::isRunningMeeGo()) {
            Qt::HANDLE handle = QMeeGoGraphicsSystemHelper::imageToEGLSharedImage(image);
            pixmap = QMeeGoGraphicsSystemHelper::pixmapFromEGLSharedImage(handle, image);
            QMeeGoGraphicsSystemHelper::destroyEGLSharedImage(handle);
        } else {
            pixmap = QPixmap::fromImage(image);
        }
        return pixmap;
    }
};

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication::setApplicationName("MeeTeeVee");
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QPixmapCache::setCacheLimit(20 * 1024);

    QmlApplicationViewer viewer;
    viewer.engine()->setNetworkAccessManagerFactory(new NetworkAccessManagerFactory);
    viewer.engine()->addImageProvider("background", new BackgroundProvider);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/MeeTeeVee/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
