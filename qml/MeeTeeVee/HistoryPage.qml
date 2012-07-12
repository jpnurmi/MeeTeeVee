/*
* Copyright (C) 2012 J-P Nurmi <jpnurmi@gmail.com>
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*/
import QtQuick 1.1
import com.nokia.meego 1.0
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
        while (historyModel.count > 10)
            historyModel.remove(10, historyModel.count - 10);
    }

    empty: listView.count <= 0
    busy: historyModel.loading && empty
    placeholder: busy ? qsTr("Loading...") : empty ? qsTr("No history") : ""

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
            Show {
                id: show
                showId: showid
            }
            title: show.name
            subtitle: show.info
            description: show.ended ? show.period : show.airing
            thumbnail: show.image
            onClicked: {
                var page = showPage.createObject(root, {showId: showid});
                pageStack.push(page);
            }
        }
    }

    Component {
        id: showPage
        ShowPage { }
    }

    onStatusChanged: {
        if (status === PageStatus.Activating && !historyModel.loaded && !historyModel.loading)
            historyModel.load();
    }
}
