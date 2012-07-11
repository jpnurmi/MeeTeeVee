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

    signal showed(string showId)

    busy: updatesModel.status === XmlListModel.Loading
    placeholder: busy ? qsTr("Loading...") : listView.count <= 0 ? qsTr("No recent updates") : ""

    flickable: ListView {
        id: listView

        cacheBuffer: 4000

        header: Header {
            title: "MeeTeeVee"
            subtitle: qsTr("Recent updates")
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

        model: XmlListModel {
            id: updatesModel
            query: "/updates/show[position() < 11]"
            XmlRole { name: "showid"; query: "id/string()"; isKey: true }
            XmlRole { name: "last"; query: "last/number()" }
            XmlRole { name: "lastepisode"; query: "lastepisode/string()" }
        }

        delegate: ShowDelegate {
            Show {
                id: show
                showId: showid
            }
            title: show.name
            subtitle: episodeModel.episode
            description: episodeModel.airdate
            thumbnail: show.image
            onClicked: {
                var page = showPage.createObject(root, {showId: showid});
                pageStack.push(page);
                root.showed(showid);
            }
            XmlListModel {
                id: episodeModel
                property string episode
                property string airdate
                source: "http://services.tvrage.com/feeds/episodeinfo.php?sid=" + showid
                query: "/show/latestepisode"
                XmlRole { name: "number"; query: "number/string()" }
                XmlRole { name: "title"; query: "title/string()" }
                XmlRole { name: "airdate"; query: "airdate/string()" }
                onCountChanged: {
                    if (count === 1) {
                        var item = get(0);
                        episode = qsTr("%1: %2").arg(item.number).arg(item.title);
                        airdate = item.airdate;
                    }
                }
            }
        }
    }

    onStatusChanged: {
        if (status === PageStatus.Activating && updatesModel.source == "")
            updatesModel.source = "http://services.tvrage.com/feeds/last_updates.php?&sort=episodes&hours=1";
    }
}
