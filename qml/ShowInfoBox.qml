/*
* Copyright (C) 2012-2014 J-P Nurmi <jpnurmi@gmail.com>
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
import QtQuick 2.1
import Sailfish.Silica 1.0

Item {
    id: root

    property Show show

    width: parent.width
    height: Math.max(column.height, width / 2)

    Thumbnail {
        id: thumbnail
        link: show.link
        source: show.image
        width: (parent.width - Theme.paddingMedium) / 2
        height: parent.height
    }

    Column {
        id: column
        width: (parent.width - Theme.paddingMedium) / 2
        anchors.right: parent.right

        ShowInfoLabel {
            title: qsTr("Classification")
            value: show.classification
        }
        ShowInfoLabel {
            title: qsTr("Network")
            value: show.network
        }
        ShowInfoLabel {
            title: qsTr("Genres")
            value: show.genres
        }
        ShowInfoLabel {
            title: qsTr("Status")
            value: show.status
        }
        ShowInfoLabel {
            title: qsTr("Started")
            value: show.started
        }
        ShowInfoLabel {
            title: qsTr("Ended")
            value: show.ended
        }
        ShowInfoLabel {
            title: qsTr("Airing")
            value: show.airing
            visible: show.airing && !show.ended
        }
        ShowInfoLabel {
            title: qsTr("Timezone")
            value: show.timezone
            visible: show.timezone && show.airtime && !show.ended
        }
        ShowInfoLabel {
            title: qsTr("Runtime")
            value: qsTr("%1 minutes").arg(show.runtime)
            visible: show.runtime
        }
    }
}
