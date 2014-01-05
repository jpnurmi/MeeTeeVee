/*
* Copyright (C) 2012-2014 J-P Nurmi <jpnurmi@gmail.com>
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
import QtQuick 2.1
import QtQuick.XmlListModel 2.0
import Sailfish.Silica 1.0

Page {
    property alias showId: show.showId

    Show {
        id: show
        fetchEpisodes: true
    }

    SilicaListView {
        id: listView

        anchors.fill: parent
        cacheBuffer: 4000

        header: PageHeader { title: show.name }

        PullDownMenu {
            MenuItem {
                text: qsTr("Favorite")
                visible: !show.favorited
                onClicked: favoritesModel.setFavorited(show.showId, true)
            }
            MenuItem {
                text: qsTr("Unfavorite")
                visible: show.favorited
                onClicked: favoritesModel.setFavorited(show.showId, false)
            }
        }

        ViewPlaceholder {
            text: show.loading && show.empty ? qsTr("Loading...") : ""
        }

        model: VisualItemModel {
            ShowInfoBox {
                id: infoBox
                show: show
                anchors { left: parent.left; right: parent.right; margins: Theme.paddingLarge }
            }

            SectionHeader { text: qsTr("Summary") }

            Label {
                id: summary
                anchors { left: parent.left; right: parent.right; margins: Theme.paddingLarge }
                visible: text.length
                text: show.summary
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                maximumLineCount: 8
            }

            SectionHeader { text: qsTr("Seasons") }

            Column {
                width: parent.width
                Repeater {
                    id: repeater
                    model: show.seasons
                    SeasonDelegate {
                        title: qsTr("Season %1").arg(index + 1)
                        subtitle: episodeListModel.busy ? qsTr("Loading...") : qsTr("%1 episodes").arg(episodeListModel.count)
                        onClicked: pageStack.push(episodeListPage, {title: show.name, model: episodeListModel})
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

    Component {
        id: episodeListPage
        EpisodeListPage { }
    }
}
