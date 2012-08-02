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

    property string error
    property bool empty: true
    property bool loading: true
    property bool favorited: false
    property bool fetchShows: true
    property bool fetchEpisodes: false

    property string info: classification && network ?
                          qsTr("%1 on %2").arg(show.classification).arg(network) :
                          classification ? classification : network
    property string period: started && ended ? qsTr("%1 - %2").arg(started).arg(ended) :
                            started ? qsTr("Started %1").arg(started) :
                            ended ? qsTr("Ended %1").arg(ended) : ""
    property string airing
    airing: {
        var strings = [];
        if (airday)
            strings.push(airday);
        if (airtime)
            strings.push(qsTr("at %1").arg(airtime));
        return strings.join(" ");
    }

    function setData(data, ready) {
        if (error && ready)
            error = "";
        empty = false;
        loading = ready;
        for (var prop in data)
            root[prop] = data[prop];
    }

    Component.onCompleted: {
        if (fetchShows && Singleton.showManager)
            Singleton.showManager.fetchShow(root);
        if (fetchEpisodes && Singleton.episodeManager)
            Singleton.episodeManager.fetchEpisodes(root);
        if (Singleton.favoritesModel)
            Singleton.favoritesModel.addShow(root);

        if (!Singleton.showManager)
            console.debug("WARNING Show.onCompleted: no ShowManager instance")
        if (!Singleton.episodeManager)
            console.debug("WARNING Show.onCompleted: no EpisodeManager instance")
        if (!Singleton.favoritesModel)
            console.debug("WARNING Show.onCompleted: no FavoritesModel instance")
    }

    Component.onDestruction: {
        if (Singleton.showManager)
            Singleton.showManager.unfetchShow(root);
        if (Singleton.episodeManager)
            Singleton.episodeManager.unfetchEpisodes(root);
        if (Singleton.favoritesModel)
            Singleton.favoritesModel.removeShow(root);
    }
}
