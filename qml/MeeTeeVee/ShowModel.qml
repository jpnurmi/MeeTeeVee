import QtQuick 1.1
import "ShowCache.js" as Cache
import "Favorites.js" as Favorites

XmlListModel {
    id: root

    property string showId
    property bool favorited

    property string name: showId ? Cache.get("name", showId, d.name) : ""
    property string link: showId ? Cache.get("link", showId, d.link) : ""
    property string seasons: showId ? Cache.get("seasons", showId, d.seasons) : ""
    property string image: showId ? Cache.get("image", showId, d.image) : ""
    property string started: showId ? Cache.get("started", showId, d.started) : ""
    property string ended: showId ? Cache.get("ended", showId, d.ended) : ""
    property string country: showId ? Cache.get("country", showId, d.country) : ""
    property string showStatus: showId ? Cache.get("status", showId, d.status) : ""
    property string classification: showId ? Cache.get("classification", showId, d.classification) : ""
    property string summary: showId ? Cache.get("summary", showId, d.summary) : ""
    property string genres: showId ? Cache.get("genres", showId, d.genres) : ""
    property string runtime: showId ? Cache.get("runtime", showId, d.runtime) : ""
    property string network: showId ? Cache.get("network", showId, d.network) : ""
    property string airtime: showId ? Cache.get("airtime", showId, d.airtime) : ""
    property string airday: showId ? Cache.get("airday", showId, d.airday) : ""
    property string timezone: showId ? Cache.get("timezone", showId, d.timezone) : ""

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

    property QtObject cache: QtObject{
        id: d
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
    }

    onCountChanged: {
        if (count === 1) {
            var item = get(0);
            d.name = item.showname;
            d.link = item.showlink;
            d.seasons = item.seasons;
            d.image = item.image;
            d.started = item.started;
            d.ended = item.ended;
            d.country = item.country;
            d.status = item.status;
            d.classification = item.classification;
            d.summary = item.summary;
            d.genres = item.genres.split("|").filter(String).join(", ");
            d.runtime = item.runtime;
            d.network = item.network;
            d.airtime = item.airtime;
            d.airday = item.airday;
            d.timezone = item.timezone;
        }
    }

    Component.onCompleted: Favorites.registerObserver(root)
    Component.onDestruction: Favorites.unregisterObserver(root)
}
