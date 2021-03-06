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
    property alias model: listView.model
    property alias title: header.title

    empty: listView.count <= 0
    busy: model && model.loading && empty
    placeholder: busy ? qsTr("Loading...") : empty && model ? qsTr("No %1").arg(title.toLowerCase()) : ""

    header: Header {
        id: header
        iconSource: "icons/clear.png"
        iconEnabled: !root.busy && !root.empty
        onIconClicked: confirmation.createObject(root).open()
    }

    flickable: ListView {
        id: listView

        cacheBuffer: 4000

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
        id: confirmation
        QueryDialog {
            id: dialog
            titleText: qsTr("Clear %1").arg(root.title.toLowerCase())
            message: qsTr("Are you sure you want to clear the %1?").arg(root.title.toLowerCase())
            acceptButtonText: qsTr("Yes")
            rejectButtonText: qsTr("No")
            onRejected: dialog.destroy(1000)
            onAccepted: { dialog.destroy(1000); root.model.clear(); }
        }
    }

    Component {
        id: showPage
        ShowPage { }
    }
}
