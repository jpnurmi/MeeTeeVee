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
import "UIConstants.js" as UI
import "Settings.js" as Settings

PageStackWindow {
    id: window

    EpisodeManager {
        id: episodeManager
    }

    ShowManager {
        id: showManager
    }

    style: PageStackWindowStyle {
        background: "image://background/MeeTeeVee"
    }

    initialPage: Page {
        orientationLock: PageOrientation.LockPortrait
        tools: tabBar
        TabGroup {
            id: tabGroup
            PageStack {
                id: homeTab
                objectName: "home"
                HomePage {
                    id: homePage
                    tools: tabBar
                    onShowed: historyModel.addShow(showId)
                }
                Component.onCompleted: homeTab.push(homePage)
            }
            PageStack {
                id: searchTab
                objectName: "search"
                SearchPage {
                    id: searchPage
                    tools: tabBar
                    onShowed: historyModel.addShow(showId)
                }
                Component.onCompleted: searchTab.push(searchPage)
            }
            PageStack {
                id: favoritesTab
                objectName: "favorites"
                ShowListPage {
                    id: favoritesPage
                    tools: tabBar
                    model: FavoritesModel {
                        id: favoritesModel
                    }
                    onShowed: historyModel.addShow(showId)
                }
                Component.onCompleted: favoritesTab.push(favoritesPage)
            }
            PageStack {
                id: historyTab
                objectName: "history"
                ShowListPage {
                    id: historyPage
                    tools: tabBar
                    model: HistoryModel {
                        id: historyModel
                    }
                }
                Component.onCompleted: historyTab.push(historyPage)
            }
        }
    }

    ToolBarLayout {
        id: tabBar
        ToolIcon {
            iconId: "toolbar-back"
            opacity: enabled ? 1.0 : UI.DISABLED_OPACITY
            enabled: !!tabGroup.currentTab && tabGroup.currentTab.depth > 1
            onClicked: tabGroup.currentTab.pop()
        }
        ButtonRow {
            exclusive: true
            TabButton {
                tab: homeTab
                iconSource: "image://theme/icon-m-toolbar-home-white"
            }
            TabButton {
                tab: searchTab
                iconSource: "image://theme/icon-m-toolbar-search-white"
            }
            TabButton {
                tab: favoritesTab
                iconSource: "image://theme/icon-m-toolbar-favorite-mark-white"
            }
            TabButton {
                tab: historyTab
                iconSource: "image://theme/icon-m-toolbar-history-white"
            }
        }
    }

    Component.onCompleted: {
        theme.inverted = true;
        var tab = Settings.read("currentTab");
        tabGroup.currentTab = tab == "search" ? searchTab :
                              tab == "favorites" ? favoritesTab :
                              tab == "history" ? historyTab : homeTab;
    }

    Component.onDestruction: Settings.write("currentTab", tabGroup.currentTab.objectName)
}
