import QtQuick 1.1

XmlListModel {
    property string seriesId
    property string language: "en"

    onSeriesIdChanged: {
        // <mirrorpath_xml>/api/<apikey>/series/<seriesid>/<language>.xm
        source = "http://www.thetvdb.com/api/621D3F0031E8B2BA/series/" + seriesId + "/" + language + ".xml"
        reload();
    }

    query: "/Data/Series"

    XmlRole { name: "id"; query: "id/string()" }
    XmlRole { name: "Actors"; query: "Actors/string()" }
    XmlRole { name: "Airs_DayOfWeek"; query: "Airs_DayOfWeek/string()" }
    XmlRole { name: "Airs_Time"; query: "Airs_Time/string()" }
    XmlRole { name: "ContentRating"; query: "ContentRating/string()" }
    XmlRole { name: "First_Aired"; query: "First_Aired/string()" }
    XmlRole { name: "Genre"; query: "Genre/string()" }
    XmlRole { name: "IMDB_ID"; query: "IMDB_ID/string()" }
    XmlRole { name: "Language"; query: "Language/string()" }
    XmlRole { name: "Network"; query: "Network/string()" }
    XmlRole { name: "NetworkID"; query: "NetworkID/string()" }
    XmlRole { name: "subtitle"; query: "Overview/string()" }
    XmlRole { name: "Rating"; query: "Rating/number()" }
    XmlRole { name: "RatingCount"; query: "RatingCount/number()" }
    XmlRole { name: "Runtime"; query: "Runtime/number()" }
    XmlRole { name: "SeriesID"; query: "SeriesID/string()" }
    XmlRole { name: "title"; query: "SeriesName/string()" }
    XmlRole { name: "Status"; query: "Status/string()" }
    XmlRole { name: "added"; query: "added/string()" }
    XmlRole { name: "addedBy"; query: "addedBy/string()" }
    XmlRole { name: "banner"; query: "banner/string()" }
    XmlRole { name: "fanart"; query: "fanart/string()" }
    XmlRole { name: "lastupdated"; query: "fanart/number()" }
    XmlRole { name: "poster"; query: "poster/string()" }
    XmlRole { name: "zap2it_id"; query: "zap2it_id/string()" }
}
