import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

CommonPage {
    id: root

    property alias title: header.title
    property alias summary: summary.text

//    busy: episodeInfoModel.status === XmlListModel.Loading
//    placeholder: busy ? qsTr("Loading...") : episodeInfoModel.count <= 0 ? qsTr("Not available") : ""

    flickable: Flickable {
        id: flickable

        contentHeight: Math.max(column.height, root.height)

        Column {
            id: column
            width: parent.width
            spacing: UI.MEDIUM_SPACING

            Header {
                id: header
                subtitle: qsTr("Summary")
            }

            Expander {
                width: parent.width
                preferredHeight: 300 // summary.height > general.height + 120 ? general.height : summary.height
                Label {
                    id: summary
                    width: parent.width
                    visible: text.length
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                }
            }
        }
    }
}
