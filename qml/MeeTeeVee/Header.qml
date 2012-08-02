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

BorderImage {
    id: root

    property alias title: label.text
    property alias iconEnabled: icon.enabled
    property alias iconSource: icon.iconSource
    signal iconClicked()

    height: label.height + UI.SMALL_SPACING + UI.MEDIUM_SPACING
    width: parent ? parent.width : 0
    source: "image://theme/meegotouch-sheet-header-inverted-background"
    border.bottom: 2

    Label {
        id: label
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: icon.left
        anchors.topMargin: UI.SMALL_SPACING
        anchors.leftMargin: UI.MEDIUM_SPACING
        anchors.rightMargin: UI.SMALL_SPACING
        font.weight: Font.Light
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.LARGE_FONT
        textFormat: Text.PlainText
        color: UI.TITLE_COLOR
    }

    ToolIcon {
        id: icon
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: -4
        height: emptyLabel.height + UI.SMALL_SPACING + UI.MEDIUM_SPACING
        opacity: enabled ? 1.0 : UI.DISABLED_OPACITY
        onClicked: root.iconClicked()
        Label {
            id: emptyLabel
            font.weight: Font.Light
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.LARGE_FONT
        }
    }
}
