import QtQuick 1.1

XmlListModel {
    property string seriesId
    property string language: "en"

    onLanguageChanged: search()
    onSeriesIdChanged: search()

    function search() {
        //source = "http://www.thetvdb.com/api/621D3F0031E8B2BA/series/" + seriesId + "/all/" + language + ".xml"
        reload();
    }

    source: "../testdata/seasons.xml"
    query: "/Data/Episode"

    XmlRole { name: "SeasonNumber"; query: "SeasonNumber/string()" }
    XmlRole { name: "EpisodeName"; query: "EpisodeName/string()" }
    XmlRole { name: "EpisodeNumber"; query: "EpisodeNumber/string()" }
    XmlRole { name: "Overview"; query: "Overview/string()" }
}
