import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

PageStackWindow {
    id: window

    initialPage: Page {
        tools: tabBar
        TabGroup {
            id: tabGroup
            currentTab: homeTab
            PageStack {
                id: homeTab
                HomePage {
                    id: homePage
                    tools: tabBar
                    onShowed: historyPage.add(showId)
                }
                Component.onCompleted: homeTab.push(homePage)
            }
            PageStack {
                id: searchTab
                SearchPage {
                    id: searchPage
                    tools: tabBar
                    onShowed: historyPage.add(showId)
                }
                Component.onCompleted: searchTab.push(searchPage)
            }
            PageStack {
                id: favoritesTab
                FavoritesPage {
                    id: favoritesPage
                    tools: tabBar
                }
                Component.onCompleted: favoritesTab.push(favoritesPage)
            }
            PageStack {
                id: historyTab
                HistoryPage {
                    id: historyPage
                    tools: tabBar
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
    }
}
