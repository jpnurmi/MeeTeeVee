import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Rectangle {
    id: root

    property alias title: label.text

    width: parent ? parent.width : 0
    height: label.height
    color: UI.INFO_COLOR

    Label {
        id: label
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: UI.MEDIUM_SPACING
    }
}
