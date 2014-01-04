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

    Component {
        id: aboutDialog
        AboutDialog { }
    }

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
