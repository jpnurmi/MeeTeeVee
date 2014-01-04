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
import QtQuick 2.1
import Sailfish.Silica 1.0

Page {
    SilicaListView {
        id: listView

        anchors.fill: parent
        cacheBuffer: 4000

        header: PageHeader { title: qsTr("History") }

        PullDownMenu {
            MenuItem {
                text: qsTr("Updates")
                onClicked: pageStack.replace(homePage)
            }
            MenuItem {
                text: qsTr("Search")
                onClicked: pageStack.replace(searchPage)
            }
            MenuItem {
                text: qsTr("Favorites")
                onClicked: pageStack.replace(favoritesPage)
            }
        }

        ViewPlaceholder {
            enabled: !listView.count
            text: qsTr("No history")
        }

        model: historyModel

        delegate: ShowDelegate {
            showId: showid
            onClicked: pageStack.push(showPage, {showId: showid})
            menu: Component {
                ContextMenu {
                    MenuItem {
                        text: qsTr("Remove")
                        onClicked: historyModel.removeShow(showId)
                    }
                }
            }
        }
    }
}
