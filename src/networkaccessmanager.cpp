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
#include "networkaccessmanager.h"
#include <QNetworkDiskCache>
#include <QDesktopServices>
#include <QNetworkRequest>

NetworkAccessManager::NetworkAccessManager(QObject *parent) :
    QNetworkAccessManager(parent)
{
}

QNetworkReply *NetworkAccessManager::createRequest(Operation operation, const QNetworkRequest &request, QIODevice *outgoingData)
{
    QNetworkRequest cacheRequest(request);
    cacheRequest.setAttribute(QNetworkRequest::CacheLoadControlAttribute, QNetworkRequest::PreferCache);
    return QNetworkAccessManager::createRequest(operation, cacheRequest, outgoingData);
}

QNetworkAccessManager *NetworkAccessManagerFactory::create(QObject *parent)
{
    QNetworkAccessManager *nam = new NetworkAccessManager(parent);
    QNetworkDiskCache *cache = new QNetworkDiskCache(nam);
    cache->setCacheDirectory(QDesktopServices::storageLocation(QDesktopServices::CacheLocation));
    nam->setCache(cache);
    return nam;
}
