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

    header: Header {
        title: show.name
        iconSource: show.favorited ? "icons/unfavorite.png" : "icons/favorite.png"
        iconEnabled: !show.empty && Singleton.favoritesModel && Singleton.favoritesModel.loaded
        onIconClicked: {
            if (Singleton.favoritesModel)
                Singleton.favoritesModel.setFavorited(show.showId, !show.favorited);
        }
    }

    flickable: Flickable {
        id: flickable

        contentHeight: column.height

        Column {
            id: column
            width: parent.width
            spacing: UI.LARGE_SPACING

            ShowInfoBox {
                id: infoBox
                show: show
            }

            Label {
                id: summary
                width: parent.width
                text: show.summary
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.MEDIUM_FONT
                elide: Text.ElideRight
                maximumLineCount: 10
            }

//            Section {
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

            Column {
                width: parent.width
                Repeater {
                    id: repeater
                    model: show.seasons
                    SeasonDelegate {
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
