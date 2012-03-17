import QtQuick 1.1
import com.nokia.meego 1.0
import "Cache.js" as Cache
import "UIConstants.js" as UI
import "History.js" as History

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
            logo: "images/tvr_logo.png"
        }

        model: ListModel {
            id: historyModel
        }

        delegate: ShowDelegate {
            title: Cache.showName(showid, showModel.name)
            subtitles: showModel.subtitles()
            thumbnail: showModel.image
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

    Component.onCompleted: {
        var history = History.restore();
        for (var i = 0; i < history.length; ++i)
            historyModel.append({"showid": history[i]});
    }

    Component.onDestruction: {
        var history = [];
        for (var i = 0; i < historyModel.count; ++i)
            history.push(historyModel.get(i).showid);
        History.save(history);
    }
}
