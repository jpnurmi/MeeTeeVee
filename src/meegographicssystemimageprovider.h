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
#ifndef MEEGOGRAPHICSSYSTEMIMAGEPROVIDER_H
#define MEEGOGRAPHICSSYSTEMIMAGEPROVIDER_H

#include <QDeclarativeImageProvider>
#include <QDir>

class MeeGoGraphicsSystemImageProvider : public QDeclarativeImageProvider
{
public:
    MeeGoGraphicsSystemImageProvider();

    QString path() const;
    void setPath(const QString& path);

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize);

private:
    QDir dir;
};

#endif // MEEGOGRAPHICSSYSTEMIMAGEPROVIDER_H
