import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow

    initialPage: Page {
        tools: commonTools
        TabGroup {
            currentTab: homeTab
            HomePage { id: homeTab }
            SearchPage { id: searchTab }
            FavoritesPage { id: favoritesTab }
            HistoryPage { id: historyTab }
        }
    }

    ToolBarLayout {
        id: commonTools
        ToolIcon {
            iconId: "toolbar-back"
            enabled: pageStack.depth > 1
            opacity: enabled ? 1.0 : 0.25
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

    Component.onCompleted: theme.inverted = true
}
