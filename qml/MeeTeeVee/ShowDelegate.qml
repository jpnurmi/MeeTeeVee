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

Item {
    id: root

    property alias showId: show.showId

    signal clicked
    signal pressAndHold

    width: parent ? parent.width : 0
    height: UI.THUMBNAIL_SIZE + 2 * UI.MEDIUM_SPACING

    Show {
        id: show
    }

    Image {
        id: thumbnail
        property bool loading: (show.empty && show.loading) || status == Image.Loading
        property bool error: status == Image.Error
        source: show.image
        anchors.verticalCenter: parent.verticalCenter
        width: UI.THUMBNAIL_SIZE; height: UI.THUMBNAIL_SIZE
        sourceSize { width: UI.THUMBNAIL_SIZE; height: UI.THUMBNAIL_SIZE }
        opacity: mouseArea.pressed && mouseArea.containsMouse ? UI.DISABLED_OPACITY : 1.0
    }

    Image {
        id: placeholder
        property bool masked: source == "image://theme/meegotouch-avatar-mask-large"
        anchors.fill: thumbnail
        source: show.error || thumbnail.error ? "image://theme/icon-l-error" :
                thumbnail.loading ? "images/downloading.png" :
                show.image ? "image://theme/meegotouch-avatar-mask-large" : "images/placeholder.png"
        opacity: !masked && mouseArea.pressed && mouseArea.containsMouse ? UI.DISABLED_OPACITY : 1.0
    }

    Column {
        id: column
        anchors.left: thumbnail.right
        anchors.leftMargin: UI.MEDIUM_SPACING
        anchors.verticalCenter: parent.verticalCenter
        width: root.width - thumbnail.width - UI.MEDIUM_SPACING

        Text {
            text: show.name
            width: column.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.MEDIUM_FONT
            font.weight: Font.Bold
            color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.TITLE_COLOR
            textFormat: Text.PlainText
            maximumLineCount: 1
        }

        Text {
            text: show.info
            width: column.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            font.weight: Font.Light
            color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.SUBTITLE_COLOR
            textFormat: Text.PlainText
            maximumLineCount: 1
        }

        Text {
            text: show.ended ? show.period : show.airing
            width: column.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            font.weight: Font.Light
            color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.SUBTITLE_COLOR
            textFormat: Text.PlainText
            maximumLineCount: 1
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
        onPressAndHold: root.pressAndHold()
    }
}
