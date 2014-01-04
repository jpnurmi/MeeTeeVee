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
import QtQuick.XmlListModel 2.0

Page {
    SilicaListView {
        id: listView

        anchors.fill: parent
        cacheBuffer: 4000

        header: SearchField {
            width: parent.width
            onTextChanged: if (searchModel.showName) searchModel.showName = ""
            Keys.onEnterPressed: { searchModel.search(text) }
            Keys.onReturnPressed: { searchModel.search(text) }
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Updates")
                onClicked: pageStack.replace(homePage)
            }
            MenuItem {
                text: qsTr("Favorites")
                onClicked: pageStack.replace(favoritesPage)
            }
            MenuItem {
                text: qsTr("History")
                onClicked: pageStack.replace(historyPage)
            }
        }

        ViewPlaceholder {
            property bool empty: listView.count <= 0
            property bool busy: searchModel.status === XmlListModel.Loading
            property string error: empty && searchModel.status === XmlListModel.Error ? searchModel.errorString() : ""
            text: busy && empty ? qsTr("Searching...") : error ? qsTr("Error") : empty ? qsTr("No results") : ""
        }

        model: SearchModel {
            id: searchModel
            function search(text) {
                showName = ""
                showName = text
                reload()
            }
        }

        delegate: ShowDelegate {
            showId: showid
            onClicked: pageStack.push(showPage, {showId: showid})
        }
    }
}
