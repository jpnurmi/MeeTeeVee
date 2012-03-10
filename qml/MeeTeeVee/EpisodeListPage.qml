import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Page {
    id: root

    property alias showId: episodeListModel.showId

    ListView {
        id: listView

        anchors.fill: parent

        model: EpisodeListModel {
            id: episodeListModel
        }

        delegate: ListItem {
            title: name
            subtitle: link
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
