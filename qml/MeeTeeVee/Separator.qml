import QtQuick 1.1
import "UIConstants.js" as UI

Row {
    id: root

    property alias title: label.text

    height: label.height
    width: parent.width
    spacing: label.text.length ? UI.LARGE_SPACING : 0

    Rectangle {
        id: leftie
        color: UI.SUBTITLE_COLOR
        height: 1
        width: 0 // 2 * UI.LARGE_SPACING
        anchors.verticalCenter: label.verticalCenter
    }

    Text {
        id: label
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.SMALL_FONT
        font.weight: Font.Light
        textFormat: Text.PlainText
        color: UI.SUBTITLE_COLOR
    }

    Rectangle {
        id: rightie
        color: UI.SUBTITLE_COLOR
        height: 1
        width: parent.width - leftie.width - label.width - parent.spacing // * 2
        anchors.verticalCenter: label.verticalCenter
    }
}
