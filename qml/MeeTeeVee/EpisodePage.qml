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

CommonPage {
    id: root

    property alias title: header.title
    property alias subtitle: subtitle.text
    property alias summary: summary.text
    property alias screencap: screencap.source
    property url link

    placeholder: title == "" && summary == "" && screencap == ""  ? qsTr("No info available") : ""

    header: Header {
        id: header
        iconSource: mouseArea.pressed && mouseArea.containsMouse ? "icons/external.png" : ""
    }

    flickable: Flickable {
        id: flickable

        contentHeight: Math.max(column.height, root.height)

        Column {
            id: column
            width: parent.width
            spacing: UI.LARGE_SPACING

            Rectangle {
                id: placeholder
                width: UI.SCREENCAP_WIDTH
                height: UI.SCREENCAP_HEIGHT
                anchors.horizontalCenter: parent.horizontalCenter
                color: UI.INFO_COLOR
                opacity: mouseArea.pressed && mouseArea.containsMouse ? UI.DISABLED_OPACITY : 1.0

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: Qt.openUrlExternally(link)
                }

                Image {
                    id: screencap
                    anchors.fill: parent
                    anchors.margins: UI.MEDIUM_SPACING
                    fillMode: Image.PreserveAspectFit
                }

                Image {
                    anchors.centerIn: parent
                    source: screencap.status == Image.Null ? "icons/image.png" : ""
                }

                BusyIndicator {
                    anchors.centerIn: parent
                    running: screencap.status == Image.Loading
                    visible: screencap.status == Image.Loading
                }
            }

            Label {
                id: subtitle
                width: parent.width
                visible: text.length
                font.weight: Font.Light
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.LARGE_FONT
            }

            Label {
                id: summary
                width: parent.width
                visible: text.length
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.MEDIUM_FONT
                elide: Text.ElideRight
                maximumLineCount: 5
            }
        }
    }
}
