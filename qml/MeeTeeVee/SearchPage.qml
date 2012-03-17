import QtQuick 1.1
import "Cache.js" as Cache

CommonPage {
    id: root

    signal showed(string showId)

    busy: searchModel.status === XmlListModel.Loading
    placeholder: busy ? qsTr("Searching...") : listView.count <= 0 ? qsTr("No results") : ""

    flickable: ListView {
        id: listView

        cacheBuffer: 4000

        header: Header {
            title: qsTr("Search")
            logo: "images/tvr_logo.png"

            SearchBox {
                id: searchBox
                width: parent.width
                placeholderText: qsTr("Search")
                onTextChanged: searchModel.showName = text
                Keys.onEnterPressed: { closeSoftwareInputPanel(); parent.forceActiveFocus(); }
                Keys.onReturnPressed: { closeSoftwareInputPanel(); parent.forceActiveFocus(); }
            }
        }

        model: SearchModel {
            id: searchModel
        }

        delegate: ShowDelegate {
            title: Cache.showName(showid, showModel.name)
            subtitles: showModel.subtitles()
            thumbnail: showModel.image
            onClicked: {
                var page = showPage.createObject(root, {model: showModel});
                pageStack.push(page);
                root.showed(showid);
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
