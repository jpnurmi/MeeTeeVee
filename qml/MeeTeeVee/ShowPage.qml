import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import "UIConstants.js" as UI

Page {
    id: root

    property ShowModel model

    BusyIndicator {
        parent: flickable.contentItem
        anchors.centerIn: parent
        visible: root.model.status === XmlListModel.Loading
        running: root.model.status === XmlListModel.Loading
        style: BusyIndicatorStyle { size: "large" }
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: Math.max(column.height, root.height)

        Column {
            id: column
            width: parent.width
            spacing: UI.MEDIUM_SPACING

            Label {
                text: root.model ? root.model.name : ""
                width: parent.width
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.LARGE_FONT
                font.weight: Font.Bold
                textFormat: Text.PlainText
            }

            ListSectionItem {
                title: qsTr("Info")
                visible: root.model.status === XmlListModel.Ready
            }

            Row {
                width: parent.width
                height: Math.max(image.height, general.height)
                spacing: UI.MEDIUM_SPACING

                Column {
                    id: general
                    width: (parent.width - parent.spacing) / 2
                    anchors.verticalCenter: parent.verticalCenter

                    Label {
                        width: parent.width
                        visible: text.length
                        text: {
                            var strings = [];
                            if (root.model && root.model.classification.length)
                                strings.push(root.model.classification);
                            if (root.model && root.model.network.length)
                                strings.push(root.model.network);
                            return strings.join(" on ");
                        }
                        font.family: UI.FONT_FAMILY
                        font.pixelSize: UI.SMALL_FONT
                        textFormat: Text.PlainText
                    }
                    Label {
                        width: parent.width
                        visible: text.length
                        text: root.model ? root.model.genres : ""
                        font.family: UI.FONT_FAMILY
                        font.pixelSize: UI.SMALL_FONT
                        textFormat: Text.PlainText
                    }
                    Label {
                        width: parent.width
                        visible: text.length
                        text: root.model ? root.model.showStatus : ""
                        font.family: UI.FONT_FAMILY
                        font.pixelSize: UI.SMALL_FONT
                        textFormat: Text.PlainText
                    }
                    Label {
                        width: parent.width
                        visible: text.length
                        text: {
                            var strings = [];
                            if (root.model && root.model.started.length)
                                strings.push(root.model.started);
                            if (root.model && root.model.ended.length)
                                strings.push(root.model.ended);
                            return strings.join(" - ");
                        }
                        font.family: UI.FONT_FAMILY
                        font.pixelSize: UI.SMALL_FONT
                        textFormat: Text.PlainText
                    }
                    Label {
                        width: parent.width
                        visible: text.length
                        text: {
                            var strings = [];
                            if (root.model && root.model.airday.length)
                                strings.push(root.model.airday);
                            if (root.model && root.model.airtime.length)
                                strings.push(qsTr("at %1").arg(root.model.airtime));
                            if (root.model && root.model.runtime.length)
                                strings.push(qsTr("(%1min)").arg(root.model.runtime));
                            return strings.join(" ");
                        }
                        font.family: UI.FONT_FAMILY
                        font.pixelSize: UI.SMALL_FONT
                        textFormat: Text.PlainText
                    }
                    RatingIndicator {
                        maximumValue: 5
                        visible: root.model.status === XmlListModel.Ready
                    }
                }

                Image {
                    id: image
                    width: (parent.width - parent.spacing) / 2
                    anchors.verticalCenter: parent.verticalCenter
                    source: root.model ? root.model.image : ""
                    fillMode: Image.PreserveAspectFit
                }
            }

            ListSectionItem {
                title: qsTr("Summary")
                visible: summary.text.length
            }

            Expander {
                width: parent.width
                preferredHeight: summary.height > general.height + 120 ? general.height : summary.height
                Label {
                    id: summary
                    width: parent.width
                    visible: text.length
                    text: root.model ? root.model.summary : ""
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                }
            }

            ListSectionItem {
                title: qsTr("Episodes")
                visible: repeater.count
            }

            Column {
                width: parent.width
                Repeater {
                    id: repeater
                    model: root.model ? root.model.seasons : 0
                    ListItem {
                        title: qsTr("Season %1").arg(index + 1)
                        subtitle: episodeListModel.count > 0 ? qsTr("%1 episodes").arg(episodeListModel.count) : qsTr("Loading...")
                        onClicked: {
                            var page = episodeListPage.createObject(root, {title: root.model.name, model: episodeListModel});
                            pageStack.push(page);
                        }
                        EpisodeListModel {
                            id: episodeListModel
                            showId: root.model.showId
                            season: index + 1
                        }
                    }
                }
            }

//            ListItem {
//                title: qsTr("Seasons and episodes")
//                subtitle: root.model ? qsTr("%1 seasons").arg(root.model.seasons) : ""
//            }

//            ListItem {
//                title: qsTr("Open TVRage.com")
//                subtitle: root.model ? root.model.link : ""
//                onClicked: Qt.openUrlExternally(root.model.link)
//            }
        }
    }

    Component {
        id: episodeListPage
        EpisodeListPage { }
    }

    ScrollDecorator {
        flickableItem: flickable
    }
}
