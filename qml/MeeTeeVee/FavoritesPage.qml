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

    empty: listView.count <= 0
    busy: favoritesModel.loading && empty
    placeholder: busy ? qsTr("Loading...") : empty ? qsTr("No favorites") : ""

    flickable: ListView {
        id: listView

        cacheBuffer: 4000

        header: Header {
            title: qsTr("Favorites")
            iconId: "toolbar-delete"
            iconEnabled: !root.empty
            onIconClicked: favoritesModel.clear()
        }

        model: FavoritesModel {
            id: favoritesModel
            Component.onCompleted: load()
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
                root.showed(showid);
            }
        }
    }

    Component {
        id: showPage
        ShowPage { }
    }
}
