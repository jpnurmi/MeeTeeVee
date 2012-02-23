import QtQuick 1.1

XmlListModel {
    property string keyword
    property string language: "en"

    onLanguageChanged: search()
    onKeywordChanged: search()

    function search() {
        source = "http://www.thetvdb.com/api/GetSeries.php?seriesname=" + keyword + "&language=" + language
        reload();
    }

    query: "/Data/Series"

    XmlRole { name: "seriesid"; query: "seriesid/string()" }
    XmlRole { name: "language"; query: "language/string()" }
    XmlRole { name: "SeriesName"; query: "SeriesName/string()" }
    XmlRole { name: "Overview"; query: "Overview/string()" }
    XmlRole { name: "banner"; query: "banner/string()" }
    XmlRole { name: "FirstAired"; query: "FirstAired/string()" }
    XmlRole { name: "IMDB_ID"; query: "IMDB_ID/string()" }
    XmlRole { name: "zap2it_id"; query: "zap2it_id/string()" }
}
