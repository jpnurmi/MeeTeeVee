import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow

    initialPage: mainPage

    MainPage {
        id: mainPage
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
                iconSource: "image://theme/icon-m-toolbar-home-white"
            }
            TabButton {
                iconSource: "image://theme/icon-m-toolbar-search-white"
            }
            TabButton {
                iconSource: "image://theme/icon-m-toolbar-favorite-mark-white"
            }
            TabButton {
                iconSource: "image://theme/icon-m-toolbar-history-white"
            }
        }
    }

    Component.onCompleted: theme.inverted = true
}
