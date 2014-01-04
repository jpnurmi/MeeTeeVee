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

        header: PageHeader { title: qsTr("Updates") }

        PullDownMenu {
            MenuItem {
                text: qsTr("History")
                onClicked: pageStack.replace(historyPage)
            }
            MenuItem {
                text: qsTr("Favorites")
                onClicked: pageStack.replace(favoritesPage)
            }
            MenuItem {
                text: qsTr("Search")
                onClicked: pageStack.replace(searchPage)
            }
        }

        ViewPlaceholder {
            property bool busy: updatesModel.status === XmlListModel.Loading
            property string error: updatesModel.status === XmlListModel.Error ? updatesModel.errorString() : ""
            enabled: !listView.count
            text: busy ? qsTr("Loading...") : error ? qsTr("Error") : qsTr("No updates")
        }

        model: XmlListModel {
            id: updatesModel
            source: "http://services.tvrage.com/feeds/last_updates.php?&sort=episodes&hours=1"
            query: "/updates/show[position() < 11]"
            XmlRole { name: "showid"; query: "id/string()"; isKey: true }
            XmlRole { name: "last"; query: "last/number()" }
            XmlRole { name: "lastepisode"; query: "lastepisode/string()" }
        }

        delegate: ShowDelegate {
            showId: showid
            onClicked: {
                historyModel.addShow(showId)
                pageStack.push(showPage, {showId: showid})
            }
        }
    }
}
