import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Item {
    id: root

    property alias title: title.text
    property alias subtitle: subtitle.text
    property alias thumbnail: thumbnail.source
    property alias thumbnailVisible: placeholder.visible

    signal clicked
    signal pressAndHold

    width: parent ? parent.width : 0
    height: column.height + 2 * UI.MEDIUM_SPACING

    Row {
        id: row

        width: parent.width
        height: parent.height
        spacing: placeholder.visible ? UI.MEDIUM_SPACING : 0

        Rectangle {
            id: placeholder
            visible: false
            width: visible ? column.height : 0
            height: visible ? column.height : 0
            color: UI.INFO_COLOR
            opacity: mouseArea.pressed ? UI.DISABLED_OPACITY : 1.0
            anchors.verticalCenter: parent.verticalCenter
            Image {
                id: thumbnail
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                sourceSize { width: parent.width; height: parent.height }
            }
        }

        Column {
            id: column
            spacing: UI.SMALL_SPACING
            anchors.verticalCenter: parent.verticalCenter
            width: row.width - placeholder.width - row.spacing

            Text {
                id: title
                width: parent.width
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.MEDIUM_FONT
                font.weight: Font.Bold
                color: mouseArea.pressed ? UI.PRESSED_COLOR : UI.TITLE_COLOR
                textFormat: Text.PlainText
                maximumLineCount: 1
                clip: true
            }

            Text {
                id: subtitle
                width: parent.width
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.SMALL_FONT
                font.weight: Font.Light
                color: mouseArea.pressed ? UI.PRESSED_COLOR : UI.SUBTITLE_COLOR
                textFormat: Text.PlainText
                maximumLineCount: 1
                clip: true
            }
        }
    }

    Image {
        id: shadow
        anchors.right: row.right
        source: "images/right-shadow.png"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
        onPressAndHold: root.pressAndHold()
    }
}
