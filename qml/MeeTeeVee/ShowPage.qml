import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import "UIConstants.js" as UI

CommonPage {
    id: root

    property ShowModel model

    busy: !!model && model.status === XmlListModel.Loading
    placeholder: busy ? qsTr("Loading...") : ""

    flickable: Flickable {
        id: flickable

        contentHeight: Math.max(column.height, root.height)

        Column {
            id: column
            width: parent.width
            spacing: UI.MEDIUM_SPACING

            Header {
                title: root.model ? root.model.name : ""
                subtitle: root.model.status === XmlListModel.Ready ? qsTr("Info") : ""
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
                    opacity: mouseArea.pressed ? UI.DISABLED_OPACITY : 1.0

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        onClicked: Qt.openUrlExternally(root.model.link)
                    }
                }
            }

            Separator {
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

            Separator {
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
                        subtitle: episodeListModel.status === XmlListModel.Loading ? qsTr("Loading...") : qsTr("%1 episodes").arg(episodeListModel.count)
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
        }
    }

    Component {
        id: episodeListPage
        EpisodeListPage { }
    }
}
