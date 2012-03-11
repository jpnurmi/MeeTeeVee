import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Page {
    id: root

    property string title
    property string subtitle
    property alias model: listView.model

    BusyIndicator {
        parent: listView.contentItem
        anchors.centerIn: parent
        visible: root.model.status === XmlListModel.Loading
        running: root.model.status === XmlListModel.Loading
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
                text: root.title
                width: parent.width
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.LARGE_FONT
                font.weight: Font.Bold
                textFormat: Text.PlainText
            }
            ListSectionItem {
                title: qsTr("Season %1").arg(root.model.season)
            }
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
