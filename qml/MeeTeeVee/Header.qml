import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Column {
    id: root

    property alias title: label.text
    property alias subtitle: separator.title
    property alias content: content.data

    spacing: UI.SMALL_SPACING
    width: parent ? parent.width : 0

    Label {
        id: label
        width: parent.width - content.width
        font.weight: Font.Light
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.LARGE_FONT
        textFormat: Text.PlainText
        color: UI.TITLE_COLOR

        Item {
            id: content
            width: childrenRect.width
            height: childrenRect.height
            anchors.left: label.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Separator {
        id: separator
        width: parent.width
        visible: label.text.length
    }
}
