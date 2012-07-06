import QtQuick 1.1
import com.nokia.meego 1.0

CommonPage {
    id: root

    //busy: favoritesModel.status === XmlListModel.Loading
    placeholder: /*busy ? qsTr("Loading...") :*/ listView.count <= 0 ? qsTr("No favorites") : ""

    flickable: ListView {
        id: listView

        cacheBuffer: 4000

        header: Header {
            title: qsTr("Favorites")
            logo: "images/tvr_logo.png"
            link: "http://www.tvrage.com"
        }

        model: ListModel {
            id: favoritesModel
        }

        delegate: ShowDelegate {
            title: showModel.name
            subtitles: [showModel.summary]
            thumbnail: showModel.image
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
