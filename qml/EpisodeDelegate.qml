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

    property alias badge: badge.text
    property alias title: title.text
    property alias subtitle: subtitle.text
    property string rating

    property bool hasSummary: false
    property bool hasScreencap: false

    Row {
        id: row

        spacing: Theme.paddingLarge
        anchors { verticalCenter: parent.verticalCenter; left: parent.left; right: parent.right; margins: Theme.paddingLarge }

        Label {
            id: badge
            anchors.baseline: column.baseline
            font.pixelSize: Theme.fontSizeExtraSmall
            width: Theme.iconSizeMedium
            height: Theme.iconSizeMedium
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Bold
            color: Theme.secondaryColor
            textFormat: Text.PlainText
        }

        Column {
            id: column
            spacing: Theme.paddingSmall
            width: row.width - badge.width - row.spacing
            baselineOffset: title.baselineOffset

            Label {
                id: title
                width: parent.width
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.primaryColor
                textFormat: Text.PlainText
                elide: Text.ElideRight
            }

            Label {
                id: subtitle
                width: parent.width
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryColor
                textFormat: Text.PlainText
                elide: Text.ElideRight
            }
        }
    }
}
