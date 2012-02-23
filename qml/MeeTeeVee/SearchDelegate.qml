import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import "UIConstants.js" as UI

Item {
    id: root

    property alias title: title.text
    property alias subtitle: subtitle.text

    signal clicked
    signal pressAndHold

    width: parent.width
    height: 88

    Column {
        id: column
        spacing: UI.SMALL_SPACING

        anchors {
            left: parent.left
            right: indicator.left
            leftMargin: UI.SMALL_SPACING
            verticalCenter: parent.verticalCenter
        }

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

    Image {
        id: shadow
        anchors.right: column.right
        source: "images/right-shadow.png"
    }

    MoreIndicator {
        id: indicator
        anchors.right: parent.right
        anchors.rightMargin: -UI.MEDIUM_SPACING
        anchors.verticalCenter: parent.verticalCenter
        opacity: mouseArea.pressed ? UI.DISABLED_OPACITY : 1.0
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
        onPressAndHold: root.pressAndHold()
    }
}
