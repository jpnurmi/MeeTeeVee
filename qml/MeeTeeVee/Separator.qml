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

Row {
    id: root

    property alias title: label.text

    height: label.height
    width: parent.width
    spacing: label.text.length ? UI.LARGE_SPACING : 0

    Text {
        id: label
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.SMALL_FONT
        font.weight: Font.Light
        textFormat: Text.PlainText
        color: UI.SUBTITLE_COLOR
    }

    Rectangle {
        id: rightie
        color: UI.SUBTITLE_COLOR
        height: 1
        width: parent.width - label.width - parent.spacing
        anchors.verticalCenter: label.verticalCenter
    }
}
