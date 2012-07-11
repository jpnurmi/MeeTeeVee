import QtQuick 1.1
import "Hash.js" as Models
import "MultiHash.js" as Shows
import "EpisodeManager.js" as Manager

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

    Component.onCompleted: Manager.instance = root
    Component.onDestruction: Manager.instance = null
}
