import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

CommonPage {
    id: root

    property alias model: listView.model

    signal showed(string showId)

    busy: model.loading
    placeholder: busy ? qsTr("Loading...") : listView.count <= 0 ? qsTr("No favorites") : ""

    flickable: ListView {
        id: listView

        cacheBuffer: 4000

        header: Header {
            title: qsTr("Favorites")
            content: Image {
                source: "images/tvr_logo.png"
                opacity: logoArea.pressed && logoArea.containsMouse ? UI.DISABLED_OPACITY : 1.0
                MouseArea {
                    id: logoArea
                    anchors.fill: parent
                    onClicked: Qt.openUrlExternally("http://www.tvrage.com")
                }
            }
        }

        delegate: ShowDelegate {
            Show {
                id: show
                showId: showid
            }
            title: show.name
            subtitle: show.genres
            //description: show.description()
            thumbnail: show.image
            onClicked: {
                var page = showPage.createObject(root, {showId: showid});
                pageStack.push(page);
                root.showed(showid);
            }
        }
    }
}
