import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Item {
    id: root

    property alias title: title.text
    property alias subtitle: subtitle.text

    signal clicked
    signal pressAndHold

    width: parent ? parent.width : 0
    height: 60 + 2 * UI.MEDIUM_SPACING

    Column {
        id: column

        width: parent.width
        anchors.verticalCenter: parent.verticalCenter

        Text {
            id: title
            width: column.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.MEDIUM_FONT
            font.weight: Font.Bold
            color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.TITLE_COLOR
            textFormat: Text.PlainText
            maximumLineCount: 1
            clip: true
            Image {
                height: parent.height
                anchors.right: parent.right
                source: "images/right-shadow.png"
            }
        }

        Text {
            id: subtitle
            width: column.width
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
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
        onPressAndHold: root.pressAndHold()
    }
}
