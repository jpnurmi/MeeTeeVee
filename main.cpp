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
