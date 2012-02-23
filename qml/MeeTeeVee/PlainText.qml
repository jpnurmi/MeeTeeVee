import QtQuick 1.1
import "UIConstants.js" as UI

Text {
    font.family: UI.FONT_FAMILY
    font.pixelSize: UI.LARGE_FONT
    color: UI.TITLE_COLOR
    textFormat: Text.PlainText

    Image {
        id: shadow
        anchors.right: parent.right
        source: "images/right-shadow.png"
        visible: parent.width < parent.implicitWidth
    }
}
