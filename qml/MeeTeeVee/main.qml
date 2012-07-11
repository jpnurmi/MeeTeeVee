import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI
import "Settings.js" as Settings

PageStackWindow {
    id: window

    ShowManager {
        id: showManager
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
                    onShowed: historyPage.add(showId)
                }
                Component.onCompleted: homeTab.push(homePage)
            }
            PageStack {
                id: searchTab
                objectName: "search"
                SearchPage {
                    id: searchPage
                    tools: tabBar
                    onShowed: historyPage.add(showId)
                }
                Component.onCompleted: searchTab.push(searchPage)
            }
            PageStack {
                id: favoritesTab
                objectName: "favorites"
                FavoritesPage {
                    id: favoritesPage
                    tools: tabBar
                    model: FavoritesModel {
                        id: favoritesModel
                    }
                    onShowed: historyPage.add(showId)
                }
                Component.onCompleted: favoritesTab.push(favoritesPage)
            }
            PageStack {
                id: historyTab
                objectName: "history"
                HistoryPage {
                    id: historyPage
                    tools: tabBar
                }
                Component.onCompleted: historyTab.push(historyPage)
            }
        }
    }

    Component {
        id: showPage
        ShowPage {
            Component.onCompleted: {
                model.favorited = favoritesModel.indexOf(model.showId) != -1;
            }
        }
    }

    ToolBarLayout {
        id: tabBar
        ToolIcon {
            iconId: "toolbar-back"
            opacity: enabled ? 1.0 : UI.DISABLED_OPACITY
            enabled: tabGroup.currentTab.depth > 1
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
        favoritesModel.load();
        var tab = Settings.read("currentTab");
        tabGroup.currentTab = tab == "search" ? searchTab :
                              tab == "favorites" ? favoritesTab :
                              tab == "history" ? historyTab : homeTab;
    }

    Component.onDestruction: Settings.write("currentTab", tabGroup.currentTab.objectName)
}
