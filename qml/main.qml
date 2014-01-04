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
import "Settings.js" as Settings

ApplicationWindow {
    id: window

    EpisodeManager {
        id: episodeManager
    }

    ShowManager {
        id: showManager
    }

    FavoritesModel {
        id: favoritesModel
    }

    HistoryModel {
        id: historyModel
    }

    Component {
        id: showPage
        ShowPage { }
    }

    Component {
        id: homePage
        HomePage { objectName: "home" }
    }

    Component {
        id: searchPage
        SearchPage { objectName: "search" }
    }

    Component {
        id: favoritesPage
        FavoritesPage { objectName: "favorites" }
    }

    Component {
        id: historyPage
        HistoryPage { objectName: "history" }
    }

//        Component {
//            id: about
//            QueryDialog {
//                id: dialog
//                acceptButtonText: qsTr("OK")
//                titleText: qsTr("MeeTeeVee v0.0.4")
//                message: qsTr("<h3>A TV show guide for Nokia N9</h3>" +
//                              "<p>Browse and track your favourite TV shows and episodes.</p>" +
//                              "<p>Copyright (C) 2012 J-P Nurmi <a href=\"mailto:jpnurmi@gmail.com\">jpnurmi@gmail.com</a></p>" +
//                              "<p><img src='%1'/></p>" +
//                              "<p><a href='http://www.tvrage.com'>TVRage.com</a> has information from over 29,000 shows and 1 million episodes in its database. Because of their user friendly contribution sections, members can easily update information such as summaries, air dates, titles, and more, regarding shows and episodes.</p>" +
//                              "<p><small>This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.</small></p>" +
//                              "<p><small>This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.</small></p>")
//                              .arg(Qt.resolvedUrl("images/banner.jpg"))
//                onLinkActivated: Qt.openUrlExternally(link)
//                onAccepted: dialog.destroy(1000)
//            }
//        }
//    }

    Component.onCompleted: {
        var tab = Settings.read("current");
        if (tab === "search")
            pageStack.push(searchPage)
        else if (tab === "favorites")
            pageStack.push(favoritesPage)
        else if (tab === "history")
            pageStack.push(historyPage)
        else
            pageStack.push(homePage)
    }

    Component.onDestruction: {
        var page = pageStack.currentPage
        while (pageStack.previousPage(page))
            page = pageStack.previousPage(page)
        Settings.write("current", page.objectName)
    }
}
