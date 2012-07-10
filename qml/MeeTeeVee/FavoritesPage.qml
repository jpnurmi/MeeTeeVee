import QtQuick 1.1
import com.nokia.meego 1.0
import "Cache.js" as Cache
import "UIConstants.js" as UI
import "Favorites.js" as Favorites

CommonPage {
    id: root

    function indexOf(showId) {
        for (var i = 0; i < favoritesModel.count; ++i) {
            if (favoritesModel.get(i).showid === showId)
                return i;
        }
        return -1;
    }

    function add(showId) {
        if (indexOf(showId) == -1) {
            favoritesModel.insert(0, {"showid": showId});
            Favorites.setFavorited(showId, true);
        }
    }

    function remove(showId) {
        var i = indexOf(showId);
        if (i != -1) {
            favoritesModel.remove(i);
            Favorites.setFavorited(showId, false);
        }
    }

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
            subtitle: Cache.showGenres(showid, showModel.genres)
            description: Cache.showDescription(showid, showModel.description())
            thumbnail: Cache.showImage(showid, showModel.image.toString())
            onClicked: {
                var page = showPage.createObject(root, {model: showModel});
                pageStack.push(page);
                root.add(showid);
            }
            ShowModel {
                id: showModel
                showId: showid
                Component.onDestruction: {
                    var page = pageStack.currentPage;
                    if (page && page.model === showModel)
                        pageStack.pop();
                }
            }
        }
    }
}
