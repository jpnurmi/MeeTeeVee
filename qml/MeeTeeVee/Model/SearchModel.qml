import QtQuick 1.1

XmlListModel {
    property string keyword: "alcatraz"
    property string language

    onKeywordChanged: {
        source = "http://www.thetvdb.com/api/GetSeries.php?seriesname=" + keyword;
        reload();
    }

    query: "/Data/Series"

    XmlRole { name: "id"; query: "id/string()" }
    XmlRole { name: "seriesId"; query: "seriesid/string()" }
    XmlRole { name: "language"; query: "language/string()" }
    XmlRole { name: "title"; query: "SeriesName/string()" }
    XmlRole { name: "subtitle"; query: "Overview/string()" }
    XmlRole { name: "iconSource"; query: "banner/string()" }
    XmlRole { name: "firstAired"; query: "FirstAired/string()" }
    XmlRole { name: "imdbId"; query: "IMDB_ID/string()" }
    XmlRole { name: "zap2itId"; query: "zap2it_id/string()" }
}
