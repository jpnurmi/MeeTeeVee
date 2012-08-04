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

    property alias showId: show.showId

    Show {
        id: show
    }

    image: [
        MaskedItem {
            id: squircle

            width: UI.THUMBNAIL_SIZE
            height: UI.THUMBNAIL_SIZE

            mask: Image {
                source: "images/squircle.png"
            }

            Image {
                id: thumbnail
                property bool loading: (show.empty && show.loading) || status == Image.Loading
                property bool error: status == Image.Error
                source: show.image
                sourceSize { width: UI.THUMBNAIL_SIZE; height: UI.THUMBNAIL_SIZE }
                opacity: root.pressed ? UI.DISABLED_OPACITY : 1.0
            }
        },
        Image {
            id: overlay
            anchors.fill: squircle
            source: (show.error && !show.empty) || thumbnail.error ? "image://theme/icon-l-error" :
                    thumbnail.loading || !show.image ? "images/squircle.png" : ""
            opacity: root.pressed ? UI.DISABLED_OPACITY : 1.0

            Image {
                anchors.centerIn: parent
                visible: thumbnail.loading || thumbnail.status == Image.Null
                source: thumbnail.loading ? "icons/download.png" :
                        thumbnail.status == Image.Null ? "icons/image.png" : ""
            }
        }
    ]

    Text {
        text: show.name
        width: parent.width
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.MEDIUM_FONT
        font.weight: Font.Bold
        color: root.pressed ? UI.PRESSED_COLOR : UI.TITLE_COLOR
        textFormat: Text.PlainText
        elide: Text.ElideRight
    }

    Text {
        text: show.info
        width: parent.width
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.SMALL_FONT
        font.weight: Font.Light
        color: root.pressed ? UI.PRESSED_COLOR : UI.SUBTITLE_COLOR
        textFormat: Text.PlainText
        elide: Text.ElideRight
    }

    Text {
        text: (show.ended ? show.period : show.airing)
              + (!show.ended && show.runtime ? qsTr(" (%1min)").arg(show.runtime) : "")
        width: parent.width
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.SMALL_FONT
        font.weight: Font.Light
        color: root.pressed ? UI.PRESSED_COLOR : UI.SUBTITLE_COLOR
        textFormat: Text.PlainText
        elide: Text.ElideRight
    }
}
