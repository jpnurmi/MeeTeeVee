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

    property alias info: info.text
    property alias genres: genres.text
    property alias status: status.text
    property alias period: period.text
    property alias airing: airing.text
    property alias image: image.source
    property string link

    width: parent.width
    height: Math.max(image.implicitHeight, column.implicitHeight)

    Column {
        id: column
        width: (parent.width - UI.MEDIUM_SPACING) / 2
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        Label {
            id: info
            width: parent.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            textFormat: Text.PlainText
            color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.TITLE_COLOR
        }
        Label {
            id: genres
            width: parent.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            textFormat: Text.PlainText
            color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.TITLE_COLOR
        }
        Label {
            id: status
            width: parent.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            textFormat: Text.PlainText
            color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.TITLE_COLOR
        }
        Label {
            id: period
            width: parent.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            textFormat: Text.PlainText
            color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.TITLE_COLOR
        }
        Label {
            id: airing
            width: parent.width
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            textFormat: Text.PlainText
            color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.TITLE_COLOR
        }
    }

    Rectangle {
        id: placeholder
        width: (parent.width - UI.MEDIUM_SPACING) / 2
        height: parent.height
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        color: image.status == Image.Ready ? "transparent" : UI.INFO_COLOR
        opacity: mouseArea.pressed && mouseArea.containsMouse ? UI.DISABLED_OPACITY : 1.0

        Image {
            id: image
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
        }

        BusyIndicator {
            anchors.centerIn: parent
            running: image.status == Image.Loading
            visible: image.status == Image.Loading
        }
    }

    Image {
        source: "image://theme/icon-s-status-notifier-software-update"
        anchors.top: parent.top
        anchors.right: parent.right
        visible: mouseArea.pressed && mouseArea.containsMouse
        rotation: 180
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: Qt.openUrlExternally(link)
    }
}
