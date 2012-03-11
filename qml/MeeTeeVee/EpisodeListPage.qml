import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Page {
    id: root

    property alias showId: episodeListModel.showId
    property alias season: episodeListModel.season
    property string showName

    BusyIndicator {
        parent: listView.contentItem
        anchors.centerIn: parent
        visible: episodeListModel.status === XmlListModel.Loading
        running: episodeListModel.status === XmlListModel.Loading
        style: BusyIndicatorStyle { size: "large" }
    }

    ListView {
        id: listView

        anchors.fill: parent

        property real headerHeight: 0

        header: Column {
            width: parent.width
            spacing: UI.MEDIUM_SPACING
            onHeightChanged: listView.headerHeight = height
            Label {
                text: root.showName
                width: parent.width
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.LARGE_FONT
                font.weight: Font.Bold
                textFormat: Text.PlainText
            }
            ListSectionItem {
                title: qsTr("Season %1").arg(root.season)
            }
        }

        model: EpisodeListModel {
            id: episodeListModel
        }

        delegate: ListItem {
            title: name
            subtitle: summary
            onClicked: Qt.openUrlExternally(link)
        }
    }

    ScrollDecorator {
        flickableItem: listView
        anchors.topMargin: listView.headerHeight + Math.abs(Math.min(0, listView.contentY))
    }
}
