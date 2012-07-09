import QtQuick 1.1
import com.nokia.meego 1.0
import "Cache.js" as Cache
import "UIConstants.js" as UI

CommonPage {
    id: root

    function add(showId) {
        for (var i = 0; i < historyModel.count; ++i) {
            if (historyModel.get(i).showid === showId) {
                historyModel.move(i, 0, 1);
                return;
            }
        }

        historyModel.insert(0, {"showid": showId});
        if (historyModel.count > 10)
            historyModel.remove(10, historyModel.count - 10);
    }

    //busy: historyModel.status === XmlListModel.Loading
    placeholder: /*busy ? qsTr("Loading...") :*/ listView.count <= 0 ? qsTr("No history") : ""

    flickable: ListView {
        id: listView

        cacheBuffer: 4000

        header: Header {
            title: qsTr("History")
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
            id: historyModel
            name: "History"
        }

        delegate: ShowDelegate {
            title: Cache.showName(showid, showModel.name)
            subtitle: showModel.genres
            description: showModel.description()
            thumbnail: Cache.showImage(showid, showModel.image.toString())
            onClicked: {
                var page = showPage.createObject(root, {model: showModel});
                pageStack.push(page);
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
