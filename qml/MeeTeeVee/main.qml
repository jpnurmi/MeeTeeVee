import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow

    property string serverTime

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

    Component.onCompleted: {
        theme.inverted = true;

        var req = new XMLHttpRequest();
        req.onreadystatechange = function() {
                    if (req.readyState === XMLHttpRequest.DONE) {
                        var root = req.responseXML.documentElement;
                        for (var i = 0; i < root.childNodes.length; ++i) {
                            var child = root.childNodes[i];
                            if (child.nodeName === "Time") {
                                appWindow.serverTime = child.firstChild.nodeValue;
                                break;
                            }
                        }
                    }
                }
        req.open("GET", "http://www.thetvdb.com/api/Updates.php?type=none");
        req.send();
    }
}
