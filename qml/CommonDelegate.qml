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

ListItem {
    id: root

    property alias image: image.data
    default property alias content: column.data

    height: Math.max(image.height, column.height) + 2 * Theme.paddingMedium

    Item {
        id: image
        width: childrenRect.width
        height: childrenRect.height
        anchors.verticalCenter: parent.verticalCenter
    }

    Column {
        id: column
        anchors.top: parent.top
        anchors.left: image.right
        anchors.right: parent.right
        anchors.topMargin: Theme.paddingMedium
        anchors.leftMargin: image.width ? Theme.paddingMedium : 0
    }
}
