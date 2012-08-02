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

    MaskedItem {
        id: squircle

        width: UI.THUMBNAIL_SIZE
        height: UI.THUMBNAIL_SIZE
        anchors.verticalCenter: parent.verticalCenter

        mask: Image {
            source: "images/squircle.png"
        }

        Image {
            id: thumbnail
            property bool loading: (show.empty && show.loading) || status == Image.Loading
            property bool error: status == Image.Error
            source: show.image
            sourceSize { width: UI.THUMBNAIL_SIZE; height: UI.THUMBNAIL_SIZE }
            opacity: mouseArea.pressed && mouseArea.containsMouse ? UI.DISABLED_OPACITY : 1.0
        }
    }

    Image {
        id: placeholder
        anchors.fill: squircle
        source: (show.error && !show.empty) || thumbnail.error ? "image://theme/icon-l-error" :
                thumbnail.loading || !show.image ? "images/squircle.png" : ""
        opacity: mouseArea.pressed && mouseArea.containsMouse ? UI.DISABLED_OPACITY : 1.0
        Image {
            anchors.centerIn: parent
            visible: thumbnail.loading || thumbnail.status == Image.Null
            source: thumbnail.loading ? "icons/download.png" :
                    thumbnail.status == Image.Null ? "icons/image.png" : ""
        }
    }

    Column {
        id: column
        anchors.left: squircle.right
        anchors.leftMargin: UI.MEDIUM_SPACING
        anchors.verticalCenter: parent.verticalCenter
        width: root.width - squircle.width - UI.MEDIUM_SPACING

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
            text: (show.ended ? show.period : show.airing)
                  + (!show.ended && show.runtime ? qsTr(" (%1min)").arg(show.runtime) : "")
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
