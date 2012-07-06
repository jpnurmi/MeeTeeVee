import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Column {
    id: root

    property alias title: label.text
    property alias subtitle: separator.title
    property alias logo: logo.source
    property url link

    spacing: UI.SMALL_SPACING
    width: parent ? parent.width : 0

    Label {
        id: label
        width: parent.width - logo.width
        font.weight: Font.Light
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.LARGE_FONT
        textFormat: Text.PlainText
        color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.TITLE_COLOR

        Image {
            id: logo
            anchors.left: label.right
            opacity: mouseArea.pressed && mouseArea.containsMouse ? UI.DISABLED_OPACITY : 1.0
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            id: mouseArea
            width: root.width
            height: label.height + UI.SMALL_SPACING
            enabled: root.link != ""
            onClicked: Qt.openUrlExternally(root.link)
        }
    }

    Separator {
        id: separator
        width: parent.width
        visible: label.text.length
    }
}
