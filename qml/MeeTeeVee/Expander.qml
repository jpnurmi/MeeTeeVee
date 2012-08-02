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
import "UIConstants.js" as UI

Item {
    id: root

    property bool expanded: false
    property bool obscured: preferredHeight < container.height
    property int duration: 250
    property real preferredHeight: 200
    default property alias data: container.data
    property bool animated: true

    clip: true
    height: (expanded ? container.height : container.minimumHeight) + (obscured ? arrow.implicitHeight : 0)

    Behavior on height {
        enabled: animated
        NumberAnimation { duration: root.duration; easing.type: Easing.InCubic }
    }

    Item {
        id: container

        property real minimumHeight: Math.min(root.preferredHeight, height)

        clip: true
        width: parent.width
        height: childrenRect.height
    }

    Image {
        id: arrow
        source: "icons/expander.png"
        height: obscured ? implicitHeight : 0
        visible: obscured
        rotation: expanded ? -180 : 0
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: mouseArea.pressed && mouseArea.containsMouse ? UI.DISABLED_OPACITY : 1.0

        Behavior on rotation { NumberAnimation { duration: root.duration; easing.type: Easing.InCubic } }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.expanded = !root.expanded
    }
}
