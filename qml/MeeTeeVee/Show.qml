import QtQuick 1.1
import "Favorites.js" as Favorites
import "ShowManager.js" as Manager

QtObject {
    id: root

    property string showId
    property bool favorited

    property string name
    property string link
    property string seasons
    property string image
    property string started
    property string ended
    property string country
    property string status
    property string classification
    property string summary
    property string genres
    property string runtime
    property string network
    property string airtime
    property string airday
    property string timezone

    function setData(data) {
        for (var prop in data)
            root[prop] = data[prop];
    }

    Component.onCompleted: {
        Manager.instance.fetchShow(root);
        Favorites.registerObserver(root);
    }

    Component.onDestruction: {
        if (Manager.instance)
            Manager.instance.unfetchShow(root);
        Favorites.unregisterObserver(root);
    }
}
