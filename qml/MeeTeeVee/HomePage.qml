import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Page {
    id: root

    BusyIndicator {
        parent: listView.contentItem
        anchors.centerIn: parent
        visible: updatesModel.status === XmlListModel.Loading
        running: updatesModel.status === XmlListModel.Loading
        style: BusyIndicatorStyle { size: "large" }
    }

    ListView {
        id: listView

        anchors.fill: parent
        cacheBuffer: 4000

        property real headerHeight: 0

        header: Column {
            width: parent.width
            spacing: UI.MEDIUM_SPACING

            onHeightChanged: listView.headerHeight = height

            Row {
                width: parent.width

                Label {
                    text: "MeeTeeVee"
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.LARGE_FONT
                    font.weight: Font.Bold
                    textFormat: Text.PlainText
                    width: parent.width - logo.width
                    anchors.verticalCenter: logo.verticalCenter
                }

                Image {
                    id: logo
                    source: "images/tvr_logo.png"
                }
            }

            Rectangle {
                color: UI.INFO_COLOR
                width: parent.width
                height: label.height
                Label {
                    id: label
                    text: qsTr("Latest updates (6h)")
                }
            }
        }

        model: XmlListModel {
            id: updatesModel
            source: "http://services.tvrage.com/feeds/last_updates.php?hours=6&sort=episodes"
            query: "/updates/show"
            XmlRole { name: "showid"; query: "id/string()" }
            XmlRole { name: "last"; query: "last/number()" }
            XmlRole { name: "lastepisode"; query: "lastepisode/string()" }
        }

        delegate: ListItem {
            title: showModel.name
            subtitle: showModel.summary
            thumbnailVisible: true
            thumbnail: showModel.image
            onClicked: {
                var page = showPage.createObject(root, {model: showModel});
                pageStack.push(page);
            }
            ShowModel {
                id: showModel
                showId: showid
            }
        }
    }

    Component {
        id: showPage
        ShowPage { }
    }

    ScrollDecorator {
        flickableItem: listView
        anchors.topMargin: listView.headerHeight + Math.abs(Math.min(0, listView.contentY))
    }
}
