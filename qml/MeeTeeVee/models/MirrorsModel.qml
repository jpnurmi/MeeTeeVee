import QtQuick 1.1

XmlListModel {
    source: "http://www.thetvdb.com/api/621D3F0031E8B2BA/mirrors.xml"
    query: "/Mirrors/Mirror"

    // typemask:
    // - 1 xml files
    // - 2 banner files
    // - 4 zip files

    XmlRole { name: "title"; query: "mirrorpath/string()" }
    XmlRole { name: "subtitle"; query: "typemask/string()" }
    XmlRole { name: "id"; query: "id/string()" }
}
