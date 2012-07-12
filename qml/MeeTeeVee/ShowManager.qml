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

    function fetchShow(show) {
        var model = createModel(show.showId);
        if (model.count == 1) {
            show.setData(model.get(0), true);
        } else {
            Shows.insert(show.showId, show);
            worker.readCache(show.showId);
        }
    }

    function unfetchShow(show) {
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
        XmlListModel {
            property string showId
            source: "http://services.tvrage.com/myfeeds/showinfo.php?key=4KvLxFFjc84XCWRggUUr&sid=" + showId
            query: "/Showinfo"
            XmlRole { name: "showId"; query: "showid/string()" }
            XmlRole { name: "name"; query: "showname/string()" }
            XmlRole { name: "link"; query: "showlink/string()" }
            XmlRole { name: "seasons"; query: "seasons/string()" }
            XmlRole { name: "image"; query: "image/string()" }
            XmlRole { name: "started"; query: "startdate/string()" }
            XmlRole { name: "ended"; query: "ended/string()" }
            XmlRole { name: "country"; query: "origin_country/string()" }
            XmlRole { name: "status"; query: "status/string()" }
            XmlRole { name: "classification"; query: "classification/string()" }
            XmlRole { name: "summary"; query: "summary/string()" }
            XmlRole { name: "genres"; query: "string-join(genres/genre,', ')" }
            XmlRole { name: "runtime"; query: "runtime/string()" }
            XmlRole { name: "network"; query: "network/string()" }
            XmlRole { name: "airtime"; query: "airtime/string()" }
            XmlRole { name: "airday"; query: "airday/string()" }
            XmlRole { name: "timezone"; query: "timezone/string()" }

            onStatusChanged: {
                var shows = Shows.values(showId);
                if (status == XmlListModel.Ready && count == 1) {
                    var data = get(0);
                    for (var i = 0; i < shows.length; ++i)
                        shows[i].setData(data, true);
                    Shows.remove(data.showId);
                    worker.writeCache(data);
                } else if (status == XmlListModel.Error) {
                    for (var j = 0; j < shows.length; ++j)
                        shows[j].error = errorString();
                }
            }
        }
    }

    property WorkerScript worker: WorkerScript {
        id: worker
        source: "ShowCache.js"

        function readCache(showId) {
            worker.sendMessage({showId: showId, operation: "read"});
        }

        function writeCache(data) {
            worker.sendMessage(data);
        }

        onMessage: {
            var shows = Shows.values(messageObject.showId);
            for (var i = 0; i < shows.length; ++i)
                shows[i].setData(messageObject, false);
        }
    }

    Component.onCompleted: Singleton.showManager = root
    Component.onDestruction: Singleton.showManager = null
}
