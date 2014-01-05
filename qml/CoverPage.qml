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

CoverBackground {
    id: cover

    signal searchRequested()
    signal favoritesRequested()

    CoverPlaceholder {
        icon.source: "images/logo.png"
    }

    Column {
        anchors.centerIn: parent
        Label {
            text: Qt.application.name
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Item { width: 1; height: Theme.paddingLarge }
        Label {
            font.pixelSize: Theme.fontSizeExtraSmall
            text: qsTr("Updates: %1").arg(updatesModel.count)
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Label {
            font.pixelSize: Theme.fontSizeExtraSmall
            text: qsTr("Favorites: %1").arg(favoritesModel.count)
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    CoverActionList {
        CoverAction {
            iconSource: "image://theme/icon-m-search"
            onTriggered: cover.searchRequested()
        }
        CoverAction {
            iconSource: "image://theme/icon-m-favorite"
            onTriggered: cover.favoritesRequested()
        }
    }
}
