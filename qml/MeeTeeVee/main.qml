import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: window

    property string serverTime

    initialPage: Page {
        tools: commonTools
        TabGroup {
            id: tabGroup
            currentTab: homeTab
            PageStack {
                id: homeTab
                HomePage { id: homePage }
                Component.onCompleted: homeTab.push(homePage)
            }
            PageStack {
                id: searchTab
                SearchPage { id: searchPage }
                Component.onCompleted: searchTab.push(searchPage)
            }
            PageStack {
                id: favoritesTab
                FavoritesPage { id: favoritesPage }
                Component.onCompleted: favoritesTab.push(favoritesPage)
            }
            PageStack {
                id: historyTab
                HistoryPage { id: historyPage }
                Component.onCompleted: historyTab.push(historyPage)
            }
        }
    }

    ToolBarLayout {
        id: commonTools
        ToolIcon {
            iconId: "toolbar-back"
            opacity: enabled ? 1.0 : 0.25
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

        var req = new XMLHttpRequest();
        req.onreadystatechange = function() {
                    if (req.readyState === XMLHttpRequest.DONE) {
                        var root = req.responseXML.documentElement;
                        for (var i = 0; i < root.childNodes.length; ++i) {
                            var child = root.childNodes[i];
                            if (child.nodeName === "Time") {
                                window.serverTime = child.firstChild.nodeValue;
                                break;
                            }
                        }
                    }
                }
        req.open("GET", "http://www.thetvdb.com/api/Updates.php?type=none");
        req.send();
    }
}
