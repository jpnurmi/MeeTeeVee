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
#include <QtGui/QApplication>
#include <QtGui/QPixmapCache>
#include <QtGui/QDesktopServices>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkDiskCache>
#include <QtNetwork/QNetworkAccessManager>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/QDeclarativeNetworkAccessManagerFactory>
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

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication::setApplicationName("MeeTeeVee");
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QPixmapCache::setCacheLimit(20 * 1024);

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/MeeTeeVee/main.qml"));
    viewer.engine()->setNetworkAccessManagerFactory(new NetworkAccessManagerFactory);
    viewer.showExpanded();

    return app->exec();
}
