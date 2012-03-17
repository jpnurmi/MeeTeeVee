#include <QtGui/QApplication>
#include <QtGui/QPixmapCache>
#include <QtGui/QDesktopServices>
#include <QtNetwork/QNetworkDiskCache>
#include <QtNetwork/QNetworkAccessManager>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/QDeclarativeNetworkAccessManagerFactory>
#include "qmlapplicationviewer.h"

class NetworkAccessManagerFactory : public QDeclarativeNetworkAccessManagerFactory
{
public:
    virtual QNetworkAccessManager *create(QObject *parent)
    {
        QNetworkAccessManager *nam = new QNetworkAccessManager(parent);
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
