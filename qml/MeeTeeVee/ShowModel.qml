import QtQuick 1.1

XmlListModel {
    id: root

    property string showId

    property string name
    property string link
    property int seasons
    property string started
    property string ended
    property url image
    property string country
    property string status
    property string classification
    property string genres
    property int runtime
    property string network
    property string airtime
    property string airday
    property string timezone

    source: "http://services.tvrage.com/feeds/full_show_info.php?sid=" + showId
    query: "/Show"

    XmlRole { name: "showname"; query: "name/string()" }
    XmlRole { name: "showlink"; query: "showlink/string()" }
    XmlRole { name: "seasons"; query: "totalseasons/number()" }
    XmlRole { name: "started"; query: "started/string()" }
    XmlRole { name: "ended"; query: "ended/string()" }
    XmlRole { name: "image"; query: "image/string()" }
    XmlRole { name: "country"; query: "origin_country/string()" }
    XmlRole { name: "status"; query: "status/string()" }
    XmlRole { name: "classification"; query: "classification/string()" }
    XmlRole { name: "genres"; query: "string-join(genres/genre,', ')" }
    XmlRole { name: "runtime"; query: "runtime/number()" }
    XmlRole { name: "network"; query: "network/string()" }
    XmlRole { name: "airtime"; query: "airtime/string()" }
    XmlRole { name: "airday"; query: "airday/string()" }
    XmlRole { name: "timezone"; query: "timezone/string()" }

    onCountChanged: {
        if (count === 1) {
            var item = get(0);
            root.name = item.showname;
            root.link = item.showlink;
            root.seasons = item.seasons;
            root.started = item.started;
            root.ended = item.ended;
            root.image = item.image;
            root.country = item.country;
            root.status = item.status;
            root.classification = item.classification;
            root.genres = item.genres;
            root.runtime = item.runtime;
            root.network = item.network;
            root.airtime = item.airtime;
            root.airday = item.airday;
            root.timezone = item.timezone;
        }
    }
}