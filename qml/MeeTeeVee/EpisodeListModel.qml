import QtQuick 1.1

XmlListModel {
    id: root

    property string showId

    source: "http://services.tvrage.com/myfeeds/episode_list.php?key=4KvLxFFjc84XCWRggUUr&sid=" + showId
    query: "/Show/Episodelist/Season/episode"

    XmlRole { name: "name"; query: "title/string()" }
    XmlRole { name: "summary"; query: "summary/string()" }
    XmlRole { name: "episode"; query: "epnum/number()" }
    XmlRole { name: "season"; query: "../@no/number()" }
    XmlRole { name: "airdate"; query: "airdate/string()" }
    XmlRole { name: "link"; query: "link/string()" }
}
