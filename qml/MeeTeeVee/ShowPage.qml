/*
* Copyright (C) 2012 J-P Nurmi <jpnurmi@gmail.com>
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*/
import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import "UIConstants.js" as UI
import "Singleton.js" as Singleton

CommonPage {
    id: root

    property alias showId: show.showId
    property alias favorited: show.favorited

    empty: show.empty
    busy: show.empty && show.loading
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
                    visible: !show.empty && Singleton.favoritesModel && Singleton.favoritesModel.loaded
                    source: favoriteArea.pressed && favoriteArea.containsMouse ?
                                "image://theme/icon-m-common-favorite-mark-inverse" :
                                show.favorited ? "image://theme/icon-m-common-favorite-mark-selected" :
                                                 "image://theme/icon-m-common-favorite-unmark-inverse"
                    MouseArea {
                        id: favoriteArea
                        anchors.fill: parent
                        onClicked: {
                            if (Singleton.favoritesModel)
                                Singleton.favoritesModel.setFavorited(show.showId, !show.favorited);
                        }
                    }
                }
            }

            ShowInfoBox {
                info: show.info
                genres: show.genres
                status: show.status
                period: show.period
                airing: show.airing
                image: show.image
                link: show.link
            }

            Separator {
                title: qsTr("Summary")
                visible: summary.text
            }

            Expander {
                width: parent.width
                visible: summary.text
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
                title: qsTr("Seasons (%1)").arg(repeater.count)
                visible: repeater.count
            }

            Column {
                width: parent.width
                Repeater {
                    id: repeater
                    model: show.seasons
                    EpisodeDelegate {
                        title: qsTr("Season %1").arg(index + 1)
                        subtitle: episodeListModel.busy ? qsTr("Loading...") : qsTr("%1 episodes").arg(episodeListModel.count)
                        onClicked: {
                            var page = episodeListPage.createObject(root, {model: episodeListModel});
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
        EpisodeListPage {
            title: show.name
        }
    }
}
