/*
* Copyright (C) 2012-2014 J-P Nurmi <jpnurmi@gmail.com>
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

MouseArea {
    id: root

    property string link
    property alias source: image.source

    enabled: !!link
    onClicked: Qt.openUrlExternally(link)

    Rectangle {
        id: background
        anchors.fill: parent
        color: Theme.rgba(Theme.highlightBackgroundColor, 0.2)
        border.color: root.link && root.pressed ? Theme.highlightBackgroundColor : "transparent"
        border.width: 1
    }

    Image {
        id: image
        anchors.fill: background
        anchors.margins: Theme.paddingSmall
        fillMode: Image.PreserveAspectFit
    }

    Image {
        anchors.centerIn: parent
        source: image.status == Image.Null ? "image://theme/icon-m-image" : ""
    }

    BusyIndicator {
        anchors.centerIn: parent
        running: image.status == Image.Loading
        visible: image.status == Image.Loading
    }
}
