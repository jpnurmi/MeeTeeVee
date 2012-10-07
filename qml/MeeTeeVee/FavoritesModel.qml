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
import QtQuick 1.1
import "Singleton.js" as Singleton
import "utils/MultiHash.js" as Shows

StorageModel {
    id: root

    function addShow(show) {
        Shows.insert(show.showId, show);
        show.favorited = indexOf(show.showId) != -1;
    }

    function removeShow(show) {
        Shows.remove(show.showId, show);
    }

    function indexOf(showId) {
        for (var i = 0; i < count; ++i) {
            if (get(i).showid === showId)
                return i;
        }
        return -1;
    }

    function setFavorited(showId, favorited) {
        var shows = Shows.values(showId);
        for (var i = 0; i < shows.length; ++i)
            shows[i].favorited = favorited;

        var idx = indexOf(showId);
        if (favorited && idx == -1)
            insert(0, {"showid": showId});
        else if (!favorited && idx != -1)
            remove(idx);
    }

    Component.onCompleted: {
        Singleton.favoritesModel = root;
        root.load("Favorites");
    }

    Component.onDestruction: {
        root.save("Favorites");
        Singleton.favoritesModel = null;
    }
}
