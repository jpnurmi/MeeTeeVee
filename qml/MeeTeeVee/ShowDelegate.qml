import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Item {
    id: root

    property alias title: title.text
    property alias subtitles: repeater.model
    property alias thumbnail: thumbnail.source
    property alias stamp: stamp.text

    signal clicked
    signal pressAndHold

    width: parent ? parent.width : 0
    height: 100 + 2 * UI.MEDIUM_SPACING

    Row {
        id: row

        width: parent.width
        height: parent.height
        spacing: placeholder.visible ? UI.MEDIUM_SPACING : 0

        Rectangle {
            id: placeholder
            width: visible ? 100 : 0
            height: visible ? 100 : 0
            color: UI.INFO_COLOR
            opacity: mouseArea.pressed ? UI.DISABLED_OPACITY : 1.0
            anchors.verticalCenter: parent.verticalCenter
            Image {
                id: thumbnail
                anchors.fill: parent
                sourceSize { width: parent.width; height: parent.height }
            }
        }

        Column {
            id: column
            anchors.verticalCenter: parent.verticalCenter
            width: row.width - placeholder.width - row.spacing

            Row {
                spacing: root.stamp.length ? UI.MEDIUM_SPACING : 0
                Text {
                    id: title
                    width: column.width - stamp.width - parent.spacing
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    font.weight: Font.Bold
                    color: mouseArea.pressed ? UI.PRESSED_COLOR : UI.TITLE_COLOR
                    textFormat: Text.PlainText
                    maximumLineCount: 1
                    clip: true
                }
                Text {
                    id: stamp
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.TINY_FONT
                    font.weight: Font.Bold
                    color: mouseArea.pressed ? UI.PRESSED_COLOR : UI.TITLE_COLOR
                    textFormat: Text.PlainText
                    maximumLineCount: 1
                    width: text.length ? undefined : 0
                    height: title.height
                    verticalAlignment: Text.AlignVCenter
                    Image {
                        height: parent.height
                        anchors.right: parent.left
                        anchors.rightMargin: UI.MEDIUM_SPACING
                        source: "images/right-shadow.png"
                    }
                }
            }

            Repeater {
                id: repeater
                Text {
                    text: root.subtitles[index]
                    width: column.width
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.SMALL_FONT
                    font.weight: Font.Light
                    color: mouseArea.pressed ? UI.PRESSED_COLOR : UI.SUBTITLE_COLOR
                    textFormat: Text.PlainText
                    maximumLineCount: 1
                    clip: true
                    Image {
                        height: parent.height
                        anchors.right: parent.right
                        source: "images/right-shadow.png"
                    }
                }
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
        onPressAndHold: root.pressAndHold()
    }
}
