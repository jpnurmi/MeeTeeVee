import QtQuick 1.1

XmlListModel {
    id: root

    property string season

    query: "/Show/Episodelist/Season[@no='"+season+"']/episode"

    XmlRole { name: "name"; query: "title/string()" }
    XmlRole { name: "summary"; query: "summary/string()" }
    XmlRole { name: "episode"; query: "seasonnum/number()" }
    XmlRole { name: "airdate"; query: "airdate/string()" }
    XmlRole { name: "link"; query: "link/string()" }
    XmlRole { name: "rating"; query: "rating/string()" }
    XmlRole { name: "screencap"; query: "screencap/string()" }
}
