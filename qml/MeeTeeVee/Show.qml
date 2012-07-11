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

QtObject {
    id: root

    property string showId
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

    property string episodes

    property bool favorited: false
    property bool fetchShows: true
    property bool fetchEpisodes: false

    property string airing
    airing: {
        if (started.length && ended.length) {
            return qsTr("%1 - %2").arg(started).arg(ended);
        } else {
            var infos = [];
            if (airday.length)
                infos.push(airday);
            if (airtime.length)
                infos.push(qsTr("at %1").arg(airtime));
            if (network.length)
                infos.push(qsTr("on %1").arg(network));
            return infos.join(" ");
        }
    }

    function setData(data) {
        for (var prop in data)
            root[prop] = data[prop];
    }

    Component.onCompleted: {
        if (fetchShows)
            Singleton.showManager.fetchShow(root);
        if (fetchEpisodes)
            Singleton.episodeManager.fetchEpisodes(root);
        Favorites.registerObserver(root);
    }

    Component.onDestruction: {
        if (Singleton.showManager)
            Singleton.showManager.unfetchShow(root);
        if (Singleton.episodeManager)
            Singleton.episodeManager.unfetchEpisodes(root);
        Favorites.unregisterObserver(root);
    }
}
