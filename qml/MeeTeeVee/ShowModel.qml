import QtQuick 1.1

XmlListModel {
    id: root

    property string showId

    property string name
    property string link
    property int seasons
    property url image
    property string started
    property date startDate
    property string ended
    property string country
    property string showStatus
    property string classification
    property string summary
    property string genres
    property int runtime
    property string network
    property string airtime
    property string airday
    property string timezone

    source: "http://services.tvrage.com/myfeeds/showinfo.php?key=4KvLxFFjc84XCWRggUUr&sid=" + showId
    query: "/Showinfo"

    XmlRole { name: "showname"; query: "showname/string()" }
    XmlRole { name: "showlink"; query: "showlink/string()" }
    XmlRole { name: "seasons"; query: "seasons/number()" }
    XmlRole { name: "image"; query: "image/string()" }
    XmlRole { name: "started"; query: "started/string()" }
    XmlRole { name: "startdate"; query: "startdate/string()" }
    XmlRole { name: "ended"; query: "ended/string()" }
    XmlRole { name: "country"; query: "origin_country/string()" }
    XmlRole { name: "status"; query: "status/string()" }
    XmlRole { name: "classification"; query: "classification/string()" }
    XmlRole { name: "summary"; query: "summary/string()" }
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
            root.image = item.image;
            root.started = item.started;
            root.startDate.setTime(item.startdate);
            root.ended = item.ended;
            root.country = item.country;
            root.showStatus = item.status;
            root.classification = item.classification;
            root.summary = item.summary;
            root.genres = item.genres;
            root.runtime = item.runtime;
            root.network = item.network;
            root.airtime = item.airtime;
            root.airday = item.airday;
            root.timezone = item.timezone;
        }
    }
}
