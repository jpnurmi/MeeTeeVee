import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import "UIConstants.js" as UI

Page {
    id: root

    property ShowModel model

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: column.height

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

            ButtonRow {
                exclusive: false
                width: parent.width
                TabButton {
                    tab: summary
                    checked: summary.visible
                    text: qsTr("Summary")
                    visible: summary.text.length
                }
                TabButton {
                    text: qsTr("Episodes...")
                    onClicked: {
                        var page = episodeListPage.createObject(root, {showId: root.model.showId, showName: root.model.name});
                        pageStack.push(page);
                    }
                }
            }

            TabGroup {
                width: parent.width
                currentTab: summary
                height: currentTab.height

                Label {
                    id: summary
                    text: root.model ? root.model.summary : ""
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    width: parent.width
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
