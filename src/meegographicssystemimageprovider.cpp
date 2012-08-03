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
#include "meegographicssystemimageprovider.h"
#include <QtMeeGoGraphicsSystemHelper>
#include <QDir>

MeeGoGraphicsSystemImageProvider::MeeGoGraphicsSystemImageProvider(const QString& imagePath) :
    QDeclarativeImageProvider(Pixmap), imagePath(imagePath)
{
}

QPixmap MeeGoGraphicsSystemImageProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    QPixmap pixmap;
    QImage image(QDir(imagePath).filePath(id));
    if (size)
        *size = image.size();
    image = image.convertToFormat(QImage::Format_ARGB32_Premultiplied);
    if (QMeeGoGraphicsSystemHelper::isRunningMeeGo()) {
        Qt::HANDLE handle = QMeeGoGraphicsSystemHelper::imageToEGLSharedImage(image);
        pixmap = QMeeGoGraphicsSystemHelper::pixmapFromEGLSharedImage(handle, image);
        QMeeGoGraphicsSystemHelper::destroyEGLSharedImage(handle);
    } else {
        pixmap = QPixmap::fromImage(image);
    }
    if (requestedSize.isValid())
        pixmap = pixmap.scaled(requestedSize);
    return pixmap;
}
