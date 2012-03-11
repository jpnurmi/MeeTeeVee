import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Page {
    id: root

    property alias showId: episodeListModel.showId
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

        header: Label {
            text: root.showName
            width: parent.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.LARGE_FONT
            font.weight: Font.Bold
            textFormat: Text.PlainText
        }

        model: EpisodeListModel {
            id: episodeListModel
        }

        delegate: ListItem {
            title: name
            subtitle: summary
            onClicked: Qt.openUrlExternally(link)
        }

        section.property: "season"
        section.delegate: Rectangle {
            color: UI.INFO_COLOR
            width: parent.width
            height: label.height
            Label {
                id: label
                text: section
            }
        }
    }

    ScrollDecorator {
        flickableItem: listView
        anchors.topMargin: 52 + Math.abs(Math.min(0, listView.contentY))
    }
}
