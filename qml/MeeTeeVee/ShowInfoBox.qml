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

    property Show show
    property bool pressed: mouseArea.pressed && mouseArea.containsMouse

    width: parent.width
    height: width / 2

    Column {
        id: column
        width: (parent.width - UI.MEDIUM_SPACING) / 2
        anchors.right: parent.right

        ShowInfoLabel {
            title: qsTr("Classification")
            value: show.classification
        }
        ShowInfoLabel {
            title: qsTr("Network")
            value: show.network
        }
        ShowInfoLabel {
            title: qsTr("Genres")
            value: show.genres
        }
        ShowInfoLabel {
            title: qsTr("Status")
            value: show.status
        }
        ShowInfoLabel {
            title: qsTr("Started")
            value: show.started
        }
        ShowInfoLabel {
            title: qsTr("Ended")
            value: show.ended
        }
        ShowInfoLabel {
            title: qsTr("Airing")
            value: show.airing
            visible: show.airing && !show.ended
        }
        ShowInfoLabel {
            title: qsTr("Timezone")
            value: show.timezone
            visible: show.timezone && show.airtime && !show.ended
        }
        ShowInfoLabel {
            title: qsTr("Runtime")
            value: qsTr("%1 minutes").arg(show.runtime)
            visible: show.runtime
        }
    }

    Rectangle {
        id: placeholder
        width: (parent.width - UI.MEDIUM_SPACING) / 2
        height: parent.height
        anchors.left: parent.left
        color: UI.INFO_COLOR
        opacity: mouseArea.pressed && mouseArea.containsMouse ? UI.DISABLED_OPACITY : 1.0

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: Qt.openUrlExternally(link)
        }

        Image {
            id: image
            source: show.image
            anchors.fill: parent
            anchors.margins: UI.MEDIUM_SPACING
            fillMode: Image.PreserveAspectFit
        }

        Image {
            anchors.centerIn: parent
            source: image.status == Image.Null ? "icons/image.png" : ""
        }

        BusyIndicator {
            anchors.centerIn: parent
            running: image.status == Image.Loading
            visible: image.status == Image.Loading
        }
    }
}
