import QtQuick 1.1

XmlListModel {
    id: root

    property string showName

    source: showName.length ? "http://services.tvrage.com/feeds/search.php?show=" + showName : ""
    query: "/Results/show"

    XmlRole { name: "showid"; query: "showid/string()" }
    XmlRole { name: "name"; query: "name/string()" }
    XmlRole { name: "link"; query: "link/string()" }
    XmlRole { name: "country"; query: "country/string()" }
    XmlRole { name: "started"; query: "started/string()" }
    XmlRole { name: "ended"; query: "ended/string()" }
    XmlRole { name: "seasons"; query: "seaons/number()" }
    XmlRole { name: "status"; query: "status/string()" }
    XmlRole { name: "classification"; query: "classification/string()" }
    XmlRole { name: "genres"; query: "string-join(genres/genre,', ')" }
}
