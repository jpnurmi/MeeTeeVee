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

Page {
    id: root

    property Flickable flickable
    property alias busy: indicator.running
    property alias placeholder: label.text

    anchors.rightMargin: UI.PAGE_MARGIN
    orientationLock: PageOrientation.LockPortrait

    onFlickableChanged: {
        if (flickable) {
            flickable.parent = root;
            flickable.anchors.fill = root;
        }
    }

    BusyIndicator {
        id: indicator
        visible: root.busy
        anchors.bottom: label.top
        anchors.bottomMargin: UI.LARGE_SPACING
        anchors.horizontalCenter: parent.horizontalCenter
        style: BusyIndicatorStyle { size: "large" }
        transform: Translate {
            y: root.flickable ? -root.flickable.contentY : 0
        }
    }

    Text {
        id: label
        font.family: UI.FONT_FAMILY_LIGHT
        font.pixelSize: UI.HUGE_FONT
        color: UI.INFO_COLOR
        anchors.baseline: parent.top
        anchors.baselineOffset: screen.displayWidth / 2
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.Wrap
        transform: Translate {
            y: root.flickable ? -root.flickable.contentY : 0
        }
    }

    ScrollDecorator {
        flickableItem: root.flickable
    }
}
