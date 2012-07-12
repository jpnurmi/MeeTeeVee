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
    property alias iconId: icon.iconId
    property alias iconEnabled: icon.enabled
    signal iconClicked()

    spacing: UI.SMALL_SPACING
    width: parent ? parent.width : 0

    Label {
        id: label
        width: parent.width - icon.width + UI.PAGE_MARGIN
        font.weight: Font.Light
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.LARGE_FONT
        textFormat: Text.PlainText
        color: UI.TITLE_COLOR

        ToolIcon {
            id: icon
            anchors.left: label.right
            anchors.verticalCenter: parent.verticalCenter
            opacity: enabled ? 1.0 : UI.DISABLED_OPACITY
            onClicked: root.iconClicked()
        }
    }

    Separator {
        id: separator
        width: parent.width
        visible: label.text.length
    }
}
