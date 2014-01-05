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

ListItem {
    id: root

    property alias showId: show.showId
    property alias favorited: show.favorited

    Show {
        id: show
    }

    contentHeight: Theme.itemSizeLarge

    Row {
        id: row

        spacing: Theme.paddingLarge
        anchors { verticalCenter: parent.verticalCenter; left: parent.left; right: parent.right; margins: Theme.paddingLarge }

        Image {
            id: thumbnail
            property bool loading: (show.empty && show.loading) || status == Image.Loading
            property bool error: status == Image.Error
            source: show.image
            width: Theme.iconSizeLarge
            height: Theme.iconSizeLarge
            fillMode: Image.PreserveAspectFit
            sourceSize { width: Theme.iconSizeLarge; height: Theme.iconSizeLarge }
            anchors { verticalCenter: parent.verticalCenter }
        }

        Column {
            spacing: Theme.paddingSmall
            width: row.width - thumbnail.width - row.spacing

            Label {
                text: show.name
                width: parent.width - indicator.width - Theme.paddingMedium
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.primaryColor
                textFormat: Text.PlainText
                elide: Text.ElideRight

                Image {
                    id: indicator
                    anchors.left: parent.right
                    anchors.margins: Theme.paddingMedium
                    anchors.verticalCenter: parent.verticalCenter
                    source: show.favorited ? "image://theme/icon-s-favorite" : ""
                }
            }

            Label {
                text: show.info
                width: parent.width
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryColor
                textFormat: Text.PlainText
                elide: Text.ElideRight
            }
        }
    }
}
