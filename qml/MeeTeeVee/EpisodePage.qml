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

    property alias title: header.title
    property alias subtitle: subtitle.text
    property alias summary: summary.text
    property alias screencap: screencap.source
    property url link

    placeholder: title == "" && summary == "" && screencap == ""  ? qsTr("No info available") : ""

    header: Header {
        id: header
    }

    flickable: Flickable {
        id: flickable

        contentHeight: column.height

        Column {
            id: column
            width: parent.width
            spacing: UI.LARGE_SPACING

            Thumbnail {
                id: screencap
                link: root.link
                width: UI.SCREENCAP_WIDTH
                height: UI.SCREENCAP_HEIGHT
            }

            Label {
                id: subtitle
                width: parent.width
                visible: text.length
                font.weight: Font.Light
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.LARGE_FONT
            }

            Label {
                id: summary
                width: parent.width
                visible: text.length
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.MEDIUM_FONT
                elide: Text.ElideRight
                maximumLineCount: 10
            }
        }
    }
}
