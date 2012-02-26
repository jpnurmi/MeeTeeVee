import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import "UIConstants.js" as UI
import "models"

Page {
    id: root

    property string seriesId
    property string title
    property url banner

    width: parent.width
    height: column.height

    onStatusChanged: {
        if (status === PageStatus.Activating) {
            model.seriesId = root.seriesId;
        }
    }

    BusyIndicator {
        visible: running
        running: model.status === XmlListModel.Loading
        style: BusyIndicatorStyle { size: "large" }
        anchors.centerIn: parent
    }

    Column {
        id: column
        width: parent.width

        Separator {
            id: separator
            title: qsTr("Overview")
            visible: overview.text !== "" && !root.loading
        }

        PlainText {
            id: overview
            width: parent.width
            font.pixelSize: UI.MEDIUM_FONT
            wrapMode: Text.WordWrap
        }

        Separator {
            title: qsTr("Information")
            visible: (infoModel.count > 0 || rating.count > 0) && !root.loading
        }

        Column {
            id: infoColumn
            width: parent.width
            spacing: UI.SMALL_SPACING
            Repeater {
                id: repeater
                model: ListModel {
                    id: infoModel
                }
                Row {
                    width: infoColumn.width
                    spacing: UI.SMALL_SPACING
                    PlainText {
                        id: keyItem
                        text: key
                        color: UI.SEPARATOR_COLOR
                        font.pixelSize: UI.MEDIUM_FONT
                    }
                    PlainText {
                        id: valueItem
                        text: value
                        font.pixelSize: UI.MEDIUM_FONT
                        wrapMode: Text.WordWrap
                        width: parent.width - keyItem.width - parent.spacing
                    }
                }
            }
            Row {
                visible: rating.count > 0
                spacing: UI.SMALL_SPACING
                PlainText { text: qsTr("Rating:"); font.pixelSize: UI.SMALL_FONT }
                RatingIndicator {
                    id: rating
                    maximumValue: 10
                }
            }
        }
    }

    SeriesModel {
        id: model
        onStatusChanged: if (status === XmlListModel.Ready && count > 0) {
            var item = model.get(0);
            if (item.banner !== "")
                root.banner = "http://www.thetvdb.com/banners/" + item.banner;
            root.title = item.SeriesName;
            overview.text = item.Overview;
            rating.ratingValue = item.Rating;
            rating.count = item.RatingCount;
            if (item.First_Aired !== "")
                infoModel.append({"key":qsTr("First aired:"), "value":item.First_Aired});
            if (item.Airs_DayOfWeek !== "")
                infoModel.append({"key":qsTr("Air day:"), "value":item.Airs_DayOfWeek});
            if (item.Airs_Time !== "")
                infoModel.append({"key":qsTr("Air time:"), "value":item.Airs_Time});
            if (item.Runtime > 0)
                infoModel.append({"key":qsTr("Runtime:"), "value":item.Runtime + " min"});
            if (item.Network !== "")
                infoModel.append({"key":qsTr("Network:"), "value":item.Network});
            if (item.Genre !== "") {
                var genres =  item.Genre.split("|").filter(String);
                if (genres.length)
                    infoModel.append({"key":qsTr("Genre:"), "value":genres.join(", ")});
            }
            if (item.Status !== "")
                infoModel.append({"key":qsTr("Status:"), "value":item.Status});
            if (item.Actors !== "") {
                var actors =  item.Actors.split("|").filter(String);
                if (actors.length)
                    infoModel.append({"key":qsTr("Actors:"), "value":actors.join(", ")});
            }
        }
    }
}
