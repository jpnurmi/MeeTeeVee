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

Item {
    id: root

    property Show show

    width: parent.width
    height: Math.max(column.height, width / 2)

    Thumbnail {
        id: thumbnail
        link: show.link
        source: show.image
        width: (parent.width - UI.MEDIUM_SPACING) / 2
        height: parent.height
    }

    Column {
        id: column
        width: (parent.width - UI.MEDIUM_SPACING) / 2
        anchors.right: parent.right

        InfoLabel {
            title: qsTr("Classification")
            value: show.classification
        }
        InfoLabel {
            title: qsTr("Network")
            value: show.network
        }
        InfoLabel {
            title: qsTr("Genres")
            value: show.genres
        }
        InfoLabel {
            title: qsTr("Status")
            value: show.status
        }
        InfoLabel {
            title: qsTr("Started")
            value: show.started
        }
        InfoLabel {
            title: qsTr("Ended")
            value: show.ended
        }
        InfoLabel {
            title: qsTr("Airing")
            value: show.airing
            visible: show.airing && !show.ended
        }
        InfoLabel {
            title: qsTr("Timezone")
            value: show.timezone
            visible: show.timezone && show.airtime && !show.ended
        }
        InfoLabel {
            title: qsTr("Runtime")
            value: qsTr("%1 minutes").arg(show.runtime)
            visible: show.runtime
        }
    }
}
