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
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Item {
    id: root

    property alias image: image.data
    default property alias content: column.data
    property bool pressed: mouseArea.pressed && mouseArea.containsMouse

    signal clicked
    signal pressAndHold

    width: parent ? parent.width : 0
    height: Math.max(image.height, column.height) + 2 * UI.MEDIUM_SPACING

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
        anchors.right: indicator.left
        anchors.topMargin: UI.MEDIUM_SPACING
        anchors.leftMargin: image.width ? UI.MEDIUM_SPACING : 0
        anchors.rightMargin: indicator.width ? UI.MEDIUM_SPACING : 0
    }

    Image {
        id: indicator
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        source: root.pressed ? "images/arrow-pressed.png" : "images/arrow.png"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked()
        onPressAndHold: root.pressAndHold()
    }
}
