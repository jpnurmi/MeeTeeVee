import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import "UIConstants.js" as UI

CommonPage {
    id: root

    property alias showId: show.showId
    property alias favorited: show.favorited

    //busy: !!model && model.status === XmlListModel.Loading
    placeholder: busy ? qsTr("Loading...") : ""

    Show {
        id: show
        fetchEpisodes: true
    }

    flickable: Flickable {
        id: flickable

        contentHeight: Math.max(column.height, root.height)

        Column {
            id: column
            width: parent.width
            spacing: UI.MEDIUM_SPACING

            Header {
                title: show.name
                subtitle: qsTr("Info")
                content: Image {
                    visible: favoritesModel.loaded
                    source: favoriteArea.pressed && favoriteArea.containsMouse ?
                                "image://theme/icon-m-common-favorite-mark-inverse" :
                                show.favorited ? "image://theme/icon-m-common-favorite-mark-selected" :
                                                 "image://theme/icon-m-common-favorite-unmark-inverse"
                    MouseArea {
                        id: favoriteArea
                        anchors.fill: parent
                        onClicked: {
                            if (!show.favorited)
                                favoritesModel.addShow(show.showId);
                            else
                                favoritesModel.removeShow(show.showId);
                        }
                    }
                }
            }

            Row {
                width: parent.width
                height: Math.max(image.height, general.height)
                spacing: UI.MEDIUM_SPACING

                Column {
                    id: general
                    height: Math.max(1, implicitHeight)
                    width: (parent.width - parent.spacing) / 2
                    anchors.verticalCenter: parent.verticalCenter

                    Label {
                        width: parent.width
                        text: {
                            var strings = [];
                            if (show.classification.length)
                                strings.push(show.classification);
                            if (show.network.length)
                                strings.push(show.network);
                            return strings.join(" on ");
                        }
                        font.family: UI.FONT_FAMILY
                        font.pixelSize: UI.SMALL_FONT
                        textFormat: Text.PlainText
                    }
                    Label {
                        width: parent.width
                        text: show.genres
                        font.family: UI.FONT_FAMILY
                        font.pixelSize: UI.SMALL_FONT
                        textFormat: Text.PlainText
                    }
                    Label {
                        width: parent.width
                        text: show.status
                        font.family: UI.FONT_FAMILY
                        font.pixelSize: UI.SMALL_FONT
                        textFormat: Text.PlainText
                    }
                    Label {
                        width: parent.width
                        text: {
                            var strings = [];
                            if (show.started.length)
                                strings.push(show.started);
                            if (show.ended.length)
                                strings.push(show.ended);
                            return strings.join(" - ");
                        }
                        font.family: UI.FONT_FAMILY
                        font.pixelSize: UI.SMALL_FONT
                        textFormat: Text.PlainText
                    }
                    Label {
                        width: parent.width
                        text: {
                            var strings = [];
                            if (show.airday.length)
                                strings.push(show.airday);
                            if (show.airtime.length)
                                strings.push(qsTr("at %1").arg(show.airtime));
                            if (show.runtime.length)
                                strings.push(qsTr("(%1min)").arg(show.runtime));
                            return strings.join(" ");
                        }
                        font.family: UI.FONT_FAMILY
                        font.pixelSize: UI.SMALL_FONT
                        textFormat: Text.PlainText
                    }
                }

                Image {
                    id: image
                    width: (parent.width - parent.spacing) / 2
                    anchors.verticalCenter: parent.verticalCenter
                    source: show.image
                    fillMode: Image.PreserveAspectFit
                    opacity: mouseArea.pressed && mouseArea.containsMouse ? UI.DISABLED_OPACITY : 1.0

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        onClicked: Qt.openUrlExternally(show.link)
                    }
                }
            }

            Separator {
                title: qsTr("Summary")
                visible: summary.text.length
            }

            Expander {
                width: parent.width
                visible: summary.text.length
                animated: root.status == PageStatus.Active
                Label {
                    id: summary
                    width: parent.width
                    text: show.summary
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                }
            }

//            Separator {
//                title: qsTr("Latest episode")
//            }

//            EpisodeDelegate {
//                title: latestEpisodeModel.count === 1 ? qsTr("%1: %2").arg(latestEpisodeModel.get(0).number).arg(latestEpisodeModel.get(0).title) : qsTr("Loading...")
//                subtitle: latestEpisodeModel.count === 1 ? latestEpisodeModel.get(0).airdate : ""
//                onClicked: {
//                    var page = episodePage.createObject(root, {showId: show.showId, number: latestEpisodeModel.get(0).number});
//                    pageStack.push(page);
//                    //root.showed(showid);
//                }
//                XmlListModel {
//                    id: latestEpisodeModel
//                    source: "http://services.tvrage.com/feeds/episodeinfo.php?sid=" + show.showId
//                    query: "/show/latestepisode"
//                    XmlRole { name: "number"; query: "number/string()" }
//                    XmlRole { name: "title"; query: "title/string()" }
//                    XmlRole { name: "airdate"; query: "airdate/string()" }
//                }
//            }

            Separator {
                title: qsTr("Seasons")
                visible: repeater.count
            }

            Column {
                width: parent.width
                Repeater {
                    id: repeater
                    model: show.seasons
                    EpisodeDelegate {
                        title: qsTr("Season %1").arg(index + 1)
                        subtitle: episodeListModel.status === XmlListModel.Loading ? qsTr("Loading...") : qsTr("%1 episodes").arg(episodeListModel.count)
                        onClicked: {
                            var page = episodeListPage.createObject(root, {title: show.name, model: episodeListModel});
                            pageStack.push(page);
                        }
                        EpisodeListModel {
                            id: episodeListModel
                            season: index + 1
                            xml: show.episodes
                        }
                    }
                }
            }
        }
    }

//    Component {
//        id: episodePage
//        EpisodePage { }
//    }

    Component {
        id: episodeListPage
        EpisodeListPage { }
    }
}
