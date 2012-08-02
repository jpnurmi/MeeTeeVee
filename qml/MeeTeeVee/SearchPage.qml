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
import "UIConstants.js" as UI

CommonPage {
    id: root

    signal showed(string showId)

    empty: listView.count <= 0
    busy: searchModel.status === XmlListModel.Loading && empty
    placeholder: busy ? qsTr("Searching...") : error ? qsTr("Error") : empty ? qsTr("No results") : ""
    error: empty && searchModel.status === XmlListModel.Error ? searchModel.errorString() : ""

    header: Header {
        SearchBox {
            id: searchBox
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: UI.MEDIUM_SPACING
            placeholderText: qsTr("Search")
            onTextChanged: if (searchModel.showName) searchModel.showName = "";
            Keys.onEnterPressed: { searchModel.search(text); closeSoftwareInputPanel(); parent.forceActiveFocus(); }
            Keys.onReturnPressed: { searchModel.search(text); closeSoftwareInputPanel(); parent.forceActiveFocus(); }
        }
    }

    flickable: ListView {
        id: listView

        cacheBuffer: 4000

        model: SearchModel {
            id: searchModel
            function search(text) {
                showName = "";
                showName = text;
                reload();
            }
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
}
