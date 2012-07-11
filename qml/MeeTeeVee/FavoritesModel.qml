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
