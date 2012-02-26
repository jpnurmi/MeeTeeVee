import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Column {
    id: root

    property alias title: label.text
    property alias banner: banner.source

    width: parent.width
    spacing: UI.MEDIUM_SPACING

    PlainText {
        id: label
        width: parent.width
    }

    Item {
        width: parent.width
        height: Math.max(background.height, banner.height)

        Image {
            id: background
            property real ratio: sourceSize.width / sourceSize.height
            width: parent.width
            height: parent.width / ratio
            source: banner.status !== Image.Ready ? "images/header.png" : ""
        }

        Image {
            id: banner
            property real ratio: sourceSize.width / sourceSize.height
            width: parent.width
            height: parent.width / ratio
        }

        BusyIndicator {
            visible: running
            running: banner.status === Image.Loading
            anchors.right: parent.right
            anchors.rightMargin: UI.PAGE_MARGIN
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
