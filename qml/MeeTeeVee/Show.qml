import QtQuick 1.1
import "Favorites.js" as Favorites
import "ShowManager.js" as ShowManager
import "EpisodeManager.js" as EpisodeManager

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
            ShowManager.instance.fetchShow(root);
        if (fetchEpisodes)
            EpisodeManager.instance.fetchEpisodes(root);
        Favorites.registerObserver(root);
    }

    Component.onDestruction: {
        if (ShowManager.instance)
            ShowManager.instance.unfetchShow(root);
        if (EpisodeManager.instance)
            EpisodeManager.instance.unfetchEpisodes(root);
        Favorites.unregisterObserver(root);
    }
}
