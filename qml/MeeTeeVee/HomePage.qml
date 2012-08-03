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

    signal about()
    signal showed(string showId)

    empty: listView.count <= 0
    busy: updatesModel.status === XmlListModel.Loading && empty
    placeholder: busy ? qsTr("Loading...") : error ? qsTr("Error") : empty ? qsTr("No recent updates") : ""
    error: empty && updatesModel.status === XmlListModel.Error ? updatesModel.errorString() : ""

    header: Header {
        title: qsTr("Recent updates")
        iconSource: "icons/help.png"
        onIconClicked: root.about()
    }

    flickable: ListView {
        id: listView

        cacheBuffer: 4000

        model: XmlListModel {
            id: updatesModel
            query: "/updates/show[position() < 11]"
            XmlRole { name: "showid"; query: "id/string()"; isKey: true }
            XmlRole { name: "last"; query: "last/number()" }
            XmlRole { name: "lastepisode"; query: "lastepisode/string()" }
        }

        delegate: ShowDelegate {
            showId: showid
            onClicked: {
                var page = showPage.createObject(root, {showId: showid});
                pageStack.push(page);
                root.showed(showid);
            }
        }
    }

    Component {
        id: showPage
        ShowPage { }
    }

    onStatusChanged: {
        if (status === PageStatus.Activating && updatesModel.source == "")
            updatesModel.source = "http://services.tvrage.com/feeds/last_updates.php?&sort=episodes&hours=1";
    }
}
