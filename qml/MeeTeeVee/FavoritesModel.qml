import QtQuick 1.1
import "Favorites.js" as Favorites
import "Singleton.js" as Singleton

StorageModel {
    id: root

    function indexOf(showId) {
        for (var i = 0; i < count; ++i) {
            if (get(i).showid === showId)
                return i;
        }
        return -1;
    }

    function addShow(showId) {
        if (indexOf(showId) == -1) {
            insert(0, {"showid": showId});
            Favorites.setFavorited(showId, true);
        }
    }

    function removeShow(showId) {
        var i = indexOf(showId);
        if (i != -1) {
            remove(i);
            Favorites.setFavorited(showId, false);
        }
    }

    name: "Favorites"

    Component.onCompleted: Singleton.favoritesModel = root
    Component.onDestruction: Singleton.favoritesModel = null
}
