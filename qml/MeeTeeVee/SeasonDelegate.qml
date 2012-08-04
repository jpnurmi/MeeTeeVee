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

CommonDelegate {
    id: root

    property alias title: title.text
    property alias subtitle: subtitle.text

    indicator: Image {
        transform: Translate { x: 6 }
        source: root.pressed ? "image://theme/icon-m-common-drilldown-arrow-inverse-disabled"
                             : "image://theme/icon-m-common-drilldown-arrow-inverse"
    }

    Text {
        id: title
        width: parent.width
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.MEDIUM_FONT
        font.weight: Font.Bold
        color: root.pressed ? UI.PRESSED_COLOR : UI.TITLE_COLOR
        textFormat: Text.PlainText
        elide: Text.ElideRight
    }

    Text {
        id: subtitle
        width: parent.width
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.SMALL_FONT
        font.weight: Font.Light
        color: root.pressed ? UI.PRESSED_COLOR : UI.SUBTITLE_COLOR
        textFormat: Text.PlainText
        elide: Text.ElideRight
    }
}
