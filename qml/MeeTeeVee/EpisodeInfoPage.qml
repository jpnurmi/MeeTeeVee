import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

CommonPage {
    id: root

    property alias showId: episodeInfoModel.showId
    property alias season: episodeInfoModel.season
    property alias episode: episodeInfoModel.episode

    busy: episodeInfoModel.status === XmlListModel.Loading
    placeholder: busy ? qsTr("Loading...") : episodeInfoModel.count <= 0 ? qsTr("Not available") : ""

    flickable: Flickable {
        id: flickable

        contentHeight: Math.max(column.height, root.height)

        Column {
            id: column
            width: parent.width
            spacing: UI.MEDIUM_SPACING

            Header {
                title: qsTr("%1x%2: %3").arg(root.season).arg(root.episode).arg(episodeInfoModel.title)
                subtitle: episodeInfoModel.status === XmlListModel.Ready ? qsTr("Summary") : ""
            }

            Expander {
                width: parent.width
                preferredHeight: 300 // summary.height > general.height + 120 ? general.height : summary.height
                Label {
                    id: summary
                    width: parent.width
                    visible: text.length
                    text: episodeInfoModel.summary
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                }
            }
        }
    }

    EpisodeInfoModel {
        id: episodeInfoModel
    }
}
