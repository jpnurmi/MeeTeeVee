import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Page {
    id: root

    property string seriesId

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: parent.width
            spacing: UI.MEDIUM_SPACING

            Header {
                id: header
                title: infoTab.title
                banner: infoTab.banner
            }

            ButtonRow {
                width: parent.width
                TabButton {
                    tab: infoTab
                    text: qsTr("Info")
                    style: ButtonStyle { }
                }
                TabButton {
                    tab: seasonsTab
                    text: qsTr("Seasons")
                    style: ButtonStyle { }
                }
            }

            TabGroup {
                width: parent.width
                height: currentTab.height
                currentTab: infoTab
                InfoTab {
                    id: infoTab
                    seriesId: root.seriesId
                }
                SeasonsTab {
                    id: seasonsTab
                    seriesId: root.seriesId
                }
            }
        }
    }
}
