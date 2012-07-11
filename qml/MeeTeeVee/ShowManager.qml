import QtQuick 1.1
import "Hash.js" as Models
import "MultiHash.js" as Shows
import "ShowManager.js" as Manager

QtObject {
    id: root

    function fetchShow(show) {
        var model = createModel(show.showId);
        if (model.count == 1)
            show.setData(model.get(0));
        else
            Shows.insert(show.showId, show);
        worker.readCache(show.showId);
    }

    function unfetchShow(show) {
        Shows.remove(show.showId, show);
    }

    function createModel(showId) {
        var model = Models.value(showId);
        if (!model) {
            model = modelComponent.createObject(root, {source: "http://services.tvrage.com/myfeeds/showinfo.php?key=4KvLxFFjc84XCWRggUUr&sid=" + showId});
            Models.insert(showId, model);
        }
        return model;
    }

    property Component component: Component {
        id: modelComponent
        XmlListModel {
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

            onCountChanged: {
                if (count == 1) {
                    var data = get(0);
                    var shows = Shows.values(data.showId);
                    for (var i = 0; i < shows.length; ++i)
                        shows[i].setData(data);
                    Shows.remove(data.showId);
                    worker.writeCache(data);
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
                shows[i].setData(messageObject);
        }
    }

    Component.onCompleted: Manager.instance = root
    Component.onDestruction: Manager.instance = null
}
