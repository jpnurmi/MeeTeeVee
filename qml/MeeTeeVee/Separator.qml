import QtQuick 1.1
import "UIConstants.js" as UI

Item {
    id: root

    property alias title: label.text

    height: label.height

    Rectangle {
        color: UI.SUBTITLE_COLOR
        height: 1
        anchors.left: parent.left
        anchors.right: label.left
        anchors.rightMargin: UI.LARGE_SPACING
        anchors.verticalCenter: label.verticalCenter
    }

    Text {
        id: label
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.SMALL_FONT
        font.weight: Font.Light
        textFormat: Text.PlainText
        color: UI.SUBTITLE_COLOR
        anchors.right: parent.right
    }
}
