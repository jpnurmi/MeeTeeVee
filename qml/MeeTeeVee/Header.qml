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
import QtQuick 2.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

BorderImage {
    id: root

    property alias title: label.text
    property alias iconEnabled: icon.enabled
    property string iconSource
    signal iconClicked()

    height: UI.HEADER_HEIGHT
    width: parent ? parent.width : 0
    source: "image://theme/meegotouch-sheet-header-inverted-background"
    border.bottom: 2

    Text {
        id: label
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: icon.left
        anchors.topMargin: UI.SMALL_SPACING
        anchors.leftMargin: UI.PAGE_MARGIN
        anchors.rightMargin: -UI.LARGE_SPACING
        font.weight: Font.Light
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.LARGE_FONT
        textFormat: Text.PlainText
        color: UI.TITLE_COLOR
        elide: Text.ElideRight
    }

    ToolIcon {
        id: icon
        iconSource: root.iconSource ? root.iconSource: "images/empty.png"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: -UI.MEDIUM_SPACING
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
