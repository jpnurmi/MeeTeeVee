import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

CommonPage {
    id: root

    //busy: favoritesModel.status === XmlListModel.Loading
    placeholder: /*busy ? qsTr("Loading...") :*/ listView.count <= 0 ? qsTr("No favorites") : ""

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

        model: StorageModel {
            id: favoritesModel
            name: "Favorites"
        }

        delegate: ShowDelegate {
            title: Cache.showName(showid, showModel.name)
            subtitle: showModel.genres
            description: showModel.description()
            thumbnail: Cache.showImage(showid, showModel.image.toString())
            onClicked: {
                var page = showPage.createObject(root, {model: showModel});
                pageStack.push(page);
                root.add(showid);
            }
            ShowModel {
                id: showModel
                showId: showid
            }
        }
    }

    Component {
        id: showPage
        ShowPage { }
    }
}
