import QtQuick 1.1

XmlListModel {
    source: "http://www.thetvdb.com/api/621D3F0031E8B2BA/languages.xml"
    query: "/Languages/Language"

    XmlRole { name: "title"; query: "name/string()" }
    XmlRole { name: "subtitle"; query: "abbreviation/string()" }
    XmlRole { name: "id"; query: "id/string()" }
}
