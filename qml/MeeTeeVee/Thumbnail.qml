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

Item {
    id: root

    property string link
    property alias source: image.source

    MouseArea {
        id: mouseArea
        property bool reallyPressed: pressed && containsMouse
        anchors.fill: parent
        onClicked: if (link) Qt.openUrlExternally(link)
    }

    Rectangle {
        anchors.fill: parent
        color: UI.INFO_COLOR
        opacity: mouseArea.reallyPressed ? UI.DISABLED_OPACITY : 1.0
        border.color: Qt.lighter(UI.INFO_COLOR)
        border.width: 1

        Image {
            id: image
            anchors.fill: parent
            anchors.margins: UI.MEDIUM_SPACING
            fillMode: Image.PreserveAspectFit
        }

        Image {
            anchors.centerIn: parent
            source: image.status == Image.Null ? "icons/image.png" : ""
        }
    }

    BusyIndicator {
        anchors.centerIn: parent
        running: image.status == Image.Loading
        visible: image.status == Image.Loading
    }

    Image {
        anchors.top: parent.top
        anchors.right: parent.right
        source: "icons/external.png"
        visible: mouseArea.reallyPressed
    }
}
