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
import Sailfish.Silica 1.0
import "UIConstants.js" as UI

ListItem {
    id: root

    property alias badge: badge.text
    property alias title: title.text
    property alias subtitle: subtitle.text
    property string rating

    property bool hasSummary: false
    property bool hasScreencap: false

    Row {
        id: row

        spacing: Theme.paddingLarge
        anchors { verticalCenter: parent.verticalCenter; left: parent.left; right: parent.right; margins: Theme.paddingLarge }

        Label {
            id: badge
            anchors.baseline: column.baseline
            font.pixelSize: Theme.fontSizeExtraSmall
            width: Theme.iconSizeMedium
            height: Theme.iconSizeMedium
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Bold
            color: Theme.secondaryColor
            textFormat: Text.PlainText
        }

        Column {
            id: column
            spacing: Theme.paddingSmall
            width: row.width - badge.width - row.spacing
            baselineOffset: title.baselineOffset

            Label {
                id: title
                width: parent.width
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.primaryColor
                textFormat: Text.PlainText
                elide: Text.ElideRight
            }

            Label {
                id: subtitle
                width: parent.width
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryColor
                textFormat: Text.PlainText
                elide: Text.ElideRight
            }
        }
    }

/*
    Text {
        id: title
        width: parent.width
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.MEDIUM_FONT
        font.weight: Font.Bold
        color: root.pressed ? UI.PRESSED_COLOR : UI.TITLE_COLOR
        textFormat: Text.PlainText
        elide: Text.ElideRight
    }

    Item {
        width: indicator.implicitWidth
        height: subtitle.height

        Text {
            id: subtitle
            anchors.left: parent.left
            anchors.right: screencapIcon.left
            anchors.rightMargin: UI.LARGE_SPACING
            font.family: UI.FONT_FAMILY
            font.pixelSize: UI.SMALL_FONT
            font.weight: Font.Light
            color: root.pressed ? UI.PRESSED_COLOR : UI.SUBTITLE_COLOR
            textFormat: Text.PlainText
            elide: Text.ElideRight
        }

        Image {
            id: screencapIcon
            visible: root.hasScreencap
            anchors.right: summaryIcon.left
            anchors.verticalCenter: subtitle.verticalCenter
            width: root.hasScreencap ? implicitWidth : 0
            source: !root.hasScreencap ? "" : root.pressed ? "images/image-pressed.png" : "images/image.png"
        }

        Image {
            id: summaryIcon
            visible: root.hasSummary
            anchors.right: parent.right
            anchors.verticalCenter: subtitle.verticalCenter
            width: root.hasSummary ? implicitWidth : 0
            source: !root.hasSummary ? "" : root.pressed ? "images/edit-pressed.png" : "images/edit.png"
        }
    }

    StarIndicator {
        id: indicator
        value: Math.round(root.rating)
        pressed: root.pressed
        visible: root.rating
    }

    Text {
        text: qsTr("No rating")
        visible: !root.rating
        font.family: UI.FONT_FAMILY
        font.pixelSize: UI.SMALL_FONT
        font.weight: Font.Light
        color: root.pressed ? UI.PRESSED_COLOR : UI.SUBTITLE_COLOR
    }
*/
}
