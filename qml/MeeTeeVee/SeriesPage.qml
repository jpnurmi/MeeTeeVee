import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import "UIConstants.js" as UI
import "models"

Page {
    id: root

    property bool loading: true
    property alias seriesId: model.seriesId

    SeriesModel {
        id: model
        onStatusChanged: if (status === XmlListModel.Ready && count > 0) {
            var item = model.get(0);
            if (item.banner !== "")
                banner.source = "http://www.thetvdb.com/banners/" + item.banner;
            name.text = item.SeriesName;
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
            root.loading = false;
        }
    }

    ListModel {
        id: infoModel
    }

    Column {
        visible: root.loading
        anchors.centerIn: parent
        BusyIndicator {
            running: root.loading
            style: BusyIndicatorStyle { size: "large" }
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: qsTr("Loading...")
            font.family: UI.FONT_FAMILY_LIGHT
            font.pixelSize: UI.HUGE_FONT
            color: UI.INFO_COLOR
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: parent.width
            spacing: UI.MEDIUM_SPACING

            Image {
                id: header
                source: "images/header.png"
                width: parent.width
                fillMode: Image.PreserveAspectFit

                BusyIndicator {
                    visible: running
                    running: banner.status === Image.Loading
                    anchors.right: parent.right
                    anchors.rightMargin: UI.PAGE_MARGIN
                    anchors.verticalCenter: parent.verticalCenter
                }

                Image {
                    id: banner
                    anchors.fill: header
                    fillMode: Image.PreserveAspectFit
                }
            }

            Item {
                width: parent.width
                height: UI.MEDIUM_SPACING
            }

            PlainText {
                id: name
                width: parent.width
            }

            Separator {
                title: qsTr("Overview")
                visible: overview.text !== "" && !root.loading
            }

            PlainText {
                id: overview
                width: parent.width
                font.pixelSize: UI.SMALL_FONT
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
                    model: infoModel
                    Row {
                        width: infoColumn.width
                        spacing: UI.SMALL_SPACING
                        PlainText {
                            id: keyItem
                            text: key
                            font.pixelSize: UI.SMALL_FONT
                        }
                        PlainText {
                            id: valueItem
                            text: value
                            font.pixelSize: UI.SMALL_FONT
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
    }
}
