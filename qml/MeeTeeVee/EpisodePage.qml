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
    property alias summary: summary.text
    property alias screencap: screencap.source

    placeholder: title == "" && summary == "" && screencap == ""  ? qsTr("No info available") : ""

    flickable: Flickable {
        id: flickable

        contentHeight: Math.max(column.height, root.height)

        Column {
            id: column
            width: parent.width
            spacing: UI.MEDIUM_SPACING

            Header {
                id: header
                subtitle: summary.text != "" ? qsTr("Summary") : screencap.source != "" ? qsTr("Screencap") : ""
            }

            Label {
                id: summary
                width: parent.width
                visible: text.length
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.MEDIUM_FONT
            }

            Separator {
                title: qsTr("Screencap")
                visible: summary.text != "" && screencap.source != ""
            }

            Image {
                id: screencap
                width: Math.min(implicitWidth, parent.width)
            }
        }
    }
}
