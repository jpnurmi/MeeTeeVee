import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

CommonPage {
    id: root

    property alias title: header.title
    property alias summary: summary.text
    property alias screencap: screencap.source

    placeholder: title == "" && summary == "" && screencap == ""  ? qsTr("No info available") : ""

    flickable: Flickable {
        id: flickable

        contentHeight: Math.max(column.height, root.height)

        Column {
            id: column
            width: parent.width
            spacing: UI.MEDIUM_SPACING

            Header {
                id: header
                subtitle: summary.text != "" ? qsTr("Summary") : screencap.source != "" ? qsTr("Screencap") : ""
            }

            Label {
                id: summary
                width: parent.width
                visible: text.length
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.MEDIUM_FONT
            }

            Separator {
                title: qsTr("Screencap")
                visible: summary.text != "" && screencap.source != ""
            }

            Image {
                id: screencap
                width: Math.min(implicitWidth, parent.width)
            }
        }
    }
}
