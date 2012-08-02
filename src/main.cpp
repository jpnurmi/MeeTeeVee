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
#include "timezoner.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication::setApplicationName("MeeTeeVee");
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QPixmapCache::setCacheLimit(20 * 1024);
    MeeGoGraphicsSystemImageProvider* provider = new MeeGoGraphicsSystemImageProvider;
    provider->setPath("/opt/MeeTeeVee/qml/MeeTeeVee/images");

    QmlApplicationViewer viewer;
    viewer.engine()->setNetworkAccessManagerFactory(new NetworkAccessManagerFactory);
    viewer.engine()->addImageProvider("MeeTeeVee", provider);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);

    TimeZoner timeZoner;
    viewer.rootContext()->setContextProperty("TimeZone", &timeZoner);

    viewer.setMainQmlFile(QLatin1String("qml/MeeTeeVee/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
