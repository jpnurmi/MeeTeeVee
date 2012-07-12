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

Row {
    id: root

    property alias info: info.text
    property alias genres: genres.text
    property alias status: status.text
    property alias period: period.text
    property alias airing: airing.text
    property alias image: image.source

    width: parent.width
    height: Math.max(image.height, column.height)
    spacing: UI.MEDIUM_SPACING

    Column {
        id: column
        height: Math.max(1, implicitHeight)
        width: (parent.width - parent.spacing) / 2
        anchors.verticalCenter: parent.verticalCenter

        Label {
            id: info
            width: parent.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            textFormat: Text.PlainText
        }
        Label {
            id: genres
            width: parent.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            textFormat: Text.PlainText
        }
        Label {
            id: status
            width: parent.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            textFormat: Text.PlainText
        }
        Label {
            id: period
            width: parent.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            textFormat: Text.PlainText
        }
        Label {
            id: airing
            width: parent.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            textFormat: Text.PlainText
        }
    }

    Image {
        id: image
        width: (parent.width - parent.spacing) / 2
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        opacity: mouseArea.pressed && mouseArea.containsMouse ? UI.DISABLED_OPACITY : 1.0

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: Qt.openUrlExternally(show.link)
        }
    }
}
