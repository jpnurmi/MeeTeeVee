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
import "Hash.js" as Models
import "MultiHash.js" as Shows
import "Singleton.js" as Singleton

QtObject {
    id: root

    function fetchEpisodes(show) {
        var model = createModel(show.showId);
        if (model.data != "")
            show.episodes = model.data;
        else
            Shows.insert(show.showId, show);
    }

    function unfetchEpisodes(show) {
        Shows.remove(show.showId, show);
    }

    function createModel(showId) {
        var model = Models.value(showId);
        if (!model) {
            model = modelComponent.createObject(root, {showId: showId});
            Models.insert(showId, model);
        }
        return model;
    }

    property Component component: Component {
        id: modelComponent
        QtObject {
            id: modelObject
            property string data
            property string showId
            property string source: "http://services.tvrage.com/myfeeds/episode_list.php?key=4KvLxFFjc84XCWRggUUr&sid=" + showId
            Component.onCompleted: {
                var doc = new XMLHttpRequest();
                doc.onreadystatechange = function() {
                    if (doc.readyState == XMLHttpRequest.DONE) {
                        modelObject.data = doc.responseText;
                        var shows = Shows.values(modelObject.showId);
                        for (var i = 0; i < shows.length; ++i)
                            shows[i].episodes = modelObject.data;
                        Shows.remove(modelObject.showId);
                    }
                }
                doc.open("GET", source);
                doc.send();
            }
        }
    }

    Component.onCompleted: Singleton.episodeManager = root
    Component.onDestruction: Singleton.episodeManager = null
}
