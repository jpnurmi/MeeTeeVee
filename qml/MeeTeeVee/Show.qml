import QtQuick 1.1
import "Favorites.js" as Favorites

QtObject {
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
    property string status
    property string classification
    property string summary
    property string genres
    property string runtime
    property string network
    property string airtime
    property string airday
    property string timezone

    property XmlListModel model: XmlListModel {
        id: model

        source: "http://services.tvrage.com/myfeeds/showinfo.php?key=4KvLxFFjc84XCWRggUUr&sid=" + showId
        query: "/Showinfo"

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
        XmlRole { name: "genres"; query: "string-join(genres/genre,'|')" }
        XmlRole { name: "runtime"; query: "runtime/string()" }
        XmlRole { name: "network"; query: "network/string()" }
        XmlRole { name: "airtime"; query: "airtime/string()" }
        XmlRole { name: "airday"; query: "airday/string()" }
        XmlRole { name: "timezone"; query: "timezone/string()" }

        onCountChanged: {
            if (count == 1) {
                var item = get(0);
                root.name = item.name;
                root.link = item.link;
                root.seasons = item.seasons;
                root.image = item.image;
                root.started = item.started;
                root.ended = item.ended;
                root.country = item.country;
                root.status = item.status;
                root.classification = item.classification;
                root.summary = item.summary;
                root.genres = item.genres.split("|").filter(String).join(", ");
                root.runtime = item.runtime;
                root.network = item.network;
                root.airtime = item.airtime;
                root.airday = item.airday;
                root.timezone = item.timezone;
            }
        }
    }

    Component.onCompleted: Favorites.registerObserver(root)
    Component.onDestruction: Favorites.unregisterObserver(root)
}
