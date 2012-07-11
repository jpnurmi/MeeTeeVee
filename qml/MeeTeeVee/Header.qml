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

Column {
    id: root

    property alias title: label.text
    property alias subtitle: separator.title
    property alias content: content.data

    spacing: UI.SMALL_SPACING
    width: parent ? parent.width : 0

    Label {
        id: label
        width: parent.width - content.width
        font.weight: Font.Light
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.LARGE_FONT
        textFormat: Text.PlainText
        color: UI.TITLE_COLOR

        Item {
            id: content
            width: childrenRect.width
            height: childrenRect.height
            anchors.left: label.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Separator {
        id: separator
        width: parent.width
        visible: label.text.length
    }
}
