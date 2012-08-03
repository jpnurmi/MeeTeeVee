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
    property string rating

    property bool hasSummary: false
    property bool hasScreencap: false

    image: Image {
        source: "images/squircle.png"
    }

    Text {
        id: title
        width: parent.width
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.MEDIUM_FONT
        font.weight: Font.Bold
        color: root.pressed ? UI.PRESSED_COLOR : UI.TITLE_COLOR
        opacity: !enabled ? UI.DISABLED_OPACITY : 1.0
        textFormat: Text.PlainText
        maximumLineCount: 1
    }

    Row {
        id: row
        width: indicator.width
        Text {
            id: subtitle
            width: parent.width - (root.hasSummary ? indicator.size : 0) - (root.hasScreencap ? indicator.size : 0)
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            font.weight: Font.Light
            color: root.pressed ? UI.PRESSED_COLOR : UI.SUBTITLE_COLOR
            textFormat: Text.PlainText
            maximumLineCount: 1
        }
        Item {
            width: indicator.size; height: indicator.size
            anchors.verticalCenter: subtitle.verticalCenter
            Image {
                id: screencapIcon
                visible: root.hasScreencap
                anchors.verticalCenter: parent.verticalCenter
                source: !root.hasScreencap ? "" : root.pressed ? "image://theme/icon-m-toolbar-gallery-dimmed-white" : "image://theme/icon-m-toolbar-gallery-white"
                sourceSize { width: 16; height: 16 }
            }
        }
        Item {
            width: indicator.size; height: indicator.size
            anchors.verticalCenter: subtitle.verticalCenter
            Image {
                id: summaryIcon
                visible: root.hasSummary
                anchors.verticalCenter: parent.verticalCenter
                source: !root.hasSummary ? "" : root.pressed ? "image://theme/icon-m-toolbar-edit-dimmed-white" : "image://theme/icon-m-toolbar-edit-white"
                sourceSize { width: 16; height: 16 }
            }
        }
    }

    StarIndicator {
        id: indicator
        property int size: width / 10
        value: Math.round(root.rating)
        visible: root.rating != ""
        opacity: root.pressed ? UI.DISABLED_OPACITY : 1.0
    }
}
