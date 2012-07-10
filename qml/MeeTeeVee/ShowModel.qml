import QtQuick 1.1
import "ShowCache.js" as Cache
import "Favorites.js" as Favorites

XmlListModel {
    id: root

    property string showId
    property bool favorited

    property string name
    property string link
    property string seasons
    property string image
    property string started
    property string ended
    property string country
    property string showStatus
    property string classification
    property string summary
    property string genres
    property string runtime
    property string network
    property string airtime
    property string airday
    property string timezone

    function description() {
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

    source: "http://services.tvrage.com/myfeeds/showinfo.php?key=4KvLxFFjc84XCWRggUUr&sid=" + showId
    query: "/Showinfo"

    XmlRole { name: "showname"; query: "showname/string()" }
    XmlRole { name: "showlink"; query: "showlink/string()" }
    XmlRole { name: "seasons"; query: "seasons/string()" }
    XmlRole { name: "image"; query: "image/string()" }
    XmlRole { name: "started"; query: "startdate/string()" }
    XmlRole { name: "ended"; query: "ended/string()" }
    XmlRole { name: "country"; query: "origin_country/string()" }
    XmlRole { name: "status"; query: "status/string()" }
    XmlRole { name: "classification"; query: "classification/string()" }
    XmlRole { name: "summary"; query: "summary/string()" }
    XmlRole { name: "genres"; query: "string-join(genres/genre,'|')" }
    XmlRole { name: "runtime"; query: "runtime/string()" }
    XmlRole { name: "network"; query: "network/string()" }
    XmlRole { name: "airtime"; query: "airtime/string()" }
    XmlRole { name: "airday"; query: "airday/string()" }
    XmlRole { name: "timezone"; query: "timezone/string()" }

    onCountChanged: {
        if (count === 1) {
            writeCache(get(0));
            readCache();
        }
    }

    onShowIdChanged: {
        if (showId !== "")
            readCache();
    }

    function readCache() {
        name = Cache.read("name", showId);
        link = Cache.read("link", showId);
        seasons = Cache.read("seasons", showId);
        image = Cache.read("image", showId);
        started = Cache.read("started", showId);
        ended = Cache.read("ended", showId);
        country = Cache.read("country", showId);
        showStatus = Cache.read("status", showId);
        classification = Cache.read("classification", showId);
        summary = Cache.read("summary", showId);
        genres = Cache.read("genres", showId);
        runtime = Cache.read("runtime", showId);
        network = Cache.read("network", showId);
        airtime = Cache.read("airtime", showId);
        airday = Cache.read("airday", showId);
        timezone = Cache.read("timezone", showId)
    }

    function writeCache(item) {
        Cache.write("name", item.showname);
        Cache.write("link", item.showlink);
        Cache.write("seasons", item.seasons);
        Cache.write("image", item.image);
        Cache.write("started", item.started);
        Cache.write("ended", item.ended);
        Cache.write("country", item.country);
        Cache.write("status", item.status);
        Cache.write("classification", item.classification);
        Cache.write("summary", item.summary);
        Cache.write("genres", item.genres.split("|").filter(String).join(", "));
        Cache.write("runtime", item.runtime);
        Cache.write("network", item.network);
        Cache.write("airtime", item.airtime);
        Cache.write("airday", item.airday);
        Cache.write("timezone", item.timezone);
    }

    Component.onCompleted: Favorites.registerObserver(root)
    Component.onDestruction: Favorites.unregisterObserver(root)
}
