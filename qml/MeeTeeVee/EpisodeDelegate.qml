import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Item {
    id: root

    property alias title: title.text
    property alias subtitle: subtitle.text
    property string rating

    property bool hasSummary: false
    property bool hasScreencap: false

    signal clicked
    signal pressAndHold

    width: parent ? parent.width : 0
    height: column.height + 2 * UI.MEDIUM_SPACING

    Column {
        id: column

        width: parent.width
        anchors.verticalCenter: parent.verticalCenter

        Row {
            Text {
                id: title
                width: column.width - (root.hasSummary ? summaryIcon.width : 0) - (root.hasScreencap ? screencapIcon.width : 0)
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.MEDIUM_FONT
                font.weight: Font.Bold
                color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.TITLE_COLOR
                opacity: !enabled ? UI.DISABLED_OPACITY : 1.0
                textFormat: Text.PlainText
                maximumLineCount: 1
                clip: true
                Image {
                    height: parent.height
                    anchors.right: parent.right
                    source: "images/right-shadow.png"
                }
            }

            Image {
                id: summaryIcon
                visible: root.hasSummary
                anchors.verticalCenter: title.verticalCenter
                source: !root.hasSummary ? "" : mouseArea.pressed ? "image://theme/icon-m-toolbar-edit-dimmed-white" : "image://theme/icon-m-toolbar-edit-white"
                sourceSize { width: 20; height: 20 }
            }

            Image {
                id: screencapIcon
                visible: root.hasScreencap
                anchors.verticalCenter: title.verticalCenter
                source: !root.hasScreencap ? "" : mouseArea.pressed ? "image://theme/icon-m-toolbar-gallery-dimmed-white" : "image://theme/icon-m-toolbar-gallery-white"
                sourceSize { width: 20; height: 20 }
            }
        }

        Row {
            id: row
            width: column.width
            Text {
                id: subtitle
                width: row.width - indicator.width
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.SMALL_FONT
                font.weight: Font.Light
                color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.SUBTITLE_COLOR
                textFormat: Text.PlainText
                maximumLineCount: 1
                clip: true
                Image {
                    height: parent.height
                    anchors.right: parent.right
                    source: "images/right-shadow.png"
                }
            }

            Row {
                id: indicator
                property int value: Math.round(root.rating)
                visible: root.rating != ""
                anchors.verticalCenter: subtitle.verticalCenter
                opacity: mouseArea.pressed && mouseArea.containsMouse ? UI.DISABLED_OPACITY : 1.0
                Repeater {
                    model: indicator.value
                    Image { source: "image://theme/meegotouch-indicator-rating-inverted-background-star" }
                }
                Repeater {
                    model: 10 - indicator.value
                    Image { source: "image://theme/meegotouch-indicator-rating-inverted-star" }
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
