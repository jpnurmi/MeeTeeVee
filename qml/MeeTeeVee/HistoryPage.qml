import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI
import "History.js" as History

Page {
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

    ListView {
        id: listView

        anchors.fill: parent
        cacheBuffer: 4000

        header: Column {
            width: parent.width
            spacing: UI.SMALL_SPACING

            Label {
                text: qsTr("History")
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.LARGE_FONT
                font.weight: Font.Bold
                textFormat: Text.PlainText
                width: parent.width
            }

            Separator { }
        }

        model: ListModel {
            id: historyModel
        }

        delegate: ListItem {
            title: showModel.name
            subtitle: showModel.summary
            thumbnailVisible: true
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
