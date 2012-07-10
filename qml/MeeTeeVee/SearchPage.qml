import QtQuick 1.1
import "UIConstants.js" as UI

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
            content: Image {
                source: "images/tvr_logo.png"
                opacity: logoArea.pressed && logoArea.containsMouse ? UI.DISABLED_OPACITY : 1.0
                MouseArea {
                    id: logoArea
                    anchors.fill: parent
                    onClicked: Qt.openUrlExternally("http://www.tvrage.com")
                }
            }

            SearchBox {
                id: searchBox
                width: parent.width
                placeholderText: qsTr("Search")
                Keys.onEnterPressed: { searchModel.showName = text; searchModel.reload(); closeSoftwareInputPanel(); parent.forceActiveFocus(); }
                Keys.onReturnPressed: { searchModel.showName = text; searchModel.reload(); closeSoftwareInputPanel(); parent.forceActiveFocus(); }
            }
        }

        model: SearchModel {
            id: searchModel
        }

        delegate: ShowDelegate {
            title: showModel.name
            subtitle: showModel.genres
            description: showModel.description()
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
}
