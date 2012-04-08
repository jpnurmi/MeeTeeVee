import QtQuick 1.1

XmlListModel {
    id: root

    property string showId
    property string season
    property string episode

    property string number
    property string title
    property string airdate
    property string url
    property string summary

    source: "http://services.tvrage.com/myfeeds/episodeinfo.php?key=4KvLxFFjc84XCWRggUUr&sid=" + showId + "&ep=" + season + "x" + episode
    query: "/show/episode"

    XmlRole { name: "number"; query: "number/string()" }
    XmlRole { name: "title"; query: "title/string()" }
    XmlRole { name: "airdate"; query: "airdate/string()" }
    XmlRole { name: "url"; query: "url/string()" }
    XmlRole { name: "summary"; query: "summary/string()" }

    onCountChanged: {
        if (count === 1) {
            var item = get(0);
            root.number = item.number;
            root.title = item.title;
            root.airdate = item.airdate;
            root.url = item.url;
            root.summary = item.summary;
        }
    }
}
