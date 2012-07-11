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

    property alias title: title.text
    property alias subtitle: subtitle.text
    property alias description: description.text
    property alias thumbnail: thumbnail.source

    signal clicked
    signal pressAndHold

    width: parent ? parent.width : 0
    height: UI.THUMBNAIL_SIZE + 2 * UI.MEDIUM_SPACING

    Row {
        id: row

        width: parent.width
        height: parent.height
        spacing: UI.MEDIUM_SPACING

        Rectangle {
            id: placeholder
            width: UI.THUMBNAIL_SIZE
            height: UI.THUMBNAIL_SIZE
            color: UI.INFO_COLOR
            opacity: mouseArea.pressed && mouseArea.containsMouse ? UI.DISABLED_OPACITY : 1.0
            anchors.verticalCenter: parent.verticalCenter
            Image {
                id: thumbnail
                anchors.fill: parent
                sourceSize { width: parent.width; height: parent.height }
            }
        }

        Column {
            id: column
            anchors.verticalCenter: parent.verticalCenter
            width: row.width - placeholder.width - UI.MEDIUM_SPACING

            Text {
                id: title
                width: column.width
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.MEDIUM_FONT
                font.weight: Font.Bold
                color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.TITLE_COLOR
                textFormat: Text.PlainText
                maximumLineCount: 1
                clip: true
            }

            Text {
                id: subtitle
                width: column.width
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.SMALL_FONT
                font.weight: Font.Light
                color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.SUBTITLE_COLOR
                textFormat: Text.PlainText
                maximumLineCount: 1
                clip: true
            }

            Text {
                id: description
                width: column.width
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.SMALL_FONT
                font.weight: Font.Light
                color: mouseArea.pressed && mouseArea.containsMouse ? UI.PRESSED_COLOR : UI.SUBTITLE_COLOR
                textFormat: Text.PlainText
                maximumLineCount: 1
                clip: true
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
        onPressAndHold: root.pressAndHold()
    }

    Image {
        height: parent.height
        anchors.right: parent.right
        source: "images/right-shadow.png"
    }
}
