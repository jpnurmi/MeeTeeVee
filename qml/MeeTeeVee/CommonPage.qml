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

Page {
    id: root

    property bool empty
    property Header header
    property Flickable flickable
    property alias busy: indicator.running
    property alias placeholder: placeholder.text
    property alias error: error.text
    default property alias data: flickableParent.data

    clip: true
    orientationLock: PageOrientation.LockPortrait

    Item {
        id: flickableParent
        property bool __isPage: true
        anchors.top: headerParent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: UI.PAGE_MARGIN
        anchors.leftMargin: UI.PAGE_MARGIN
        anchors.rightMargin: UI.PAGE_MARGIN + UI.MEDIUM_SPACING

        ScrollDecorator {
            id: scroller
        }
    }

    Item {
        id: headerParent
        width: parent.width
        height: childrenRect.height
    }

    onHeaderChanged: {
        if (header)
            header.parent = headerParent;
    }

    onFlickableChanged: {
        if (flickable) {
            flickable.parent = flickableParent;
            flickable.anchors.fill = flickableParent;
        }
        scroller.flickableItem = flickable;
    }

    BusyIndicator {
        id: indicator
        visible: root.busy
        anchors.bottom: placeholder.top
        anchors.bottomMargin: UI.LARGE_SPACING
        anchors.horizontalCenter: parent.horizontalCenter
        style: BusyIndicatorStyle { size: "large" }
        transform: Translate {
            y: root.flickable ? -root.flickable.contentY : 0
        }
    }

    Text {
        id: placeholder
        font.family: UI.FONT_FAMILY_LIGHT
        font.pixelSize: UI.HUGE_FONT
        color: error.text ? UI.ERROR_COLOR : UI.INFO_COLOR
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

    Text {
        id: error
        font.family: UI.FONT_FAMILY_LIGHT
        font.pixelSize: UI.MEDIUM_FONT
        color: UI.ERROR_COLOR
        anchors.top: placeholder.bottom
        anchors.topMargin: UI.MEDIUM_SPACING
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.Wrap
        transform: Translate {
            y: root.flickable ? -root.flickable.contentY : 0
        }
    }
}
