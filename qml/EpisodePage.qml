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

Page {
    id: page

    property string title
    property alias subtitle: subtitle.text
    property alias summary: summary.text
    property alias screencap: screencap.source
    property url link

    SilicaListView {
        id: listView

        anchors.fill: parent
        cacheBuffer: 4000

        header: PageHeader { title: page.title }

        ViewPlaceholder {
            enabled: !title && !summary && !screencap
            text: qsTr("No info available")
        }

        model: VisualItemModel {

            Thumbnail {
                id: screencap
                link: page.link
                width: Screen.width / 3 * 2
                height: Screen.width / 2
                anchors { left: parent.left; margins: Theme.paddingLarge }
            }

            SectionHeader {
                id: subtitle
                visible: text.length
            }

            Label {
                id: summary
                anchors { left: parent.left; right: parent.right; margins: Theme.paddingLarge }
                visible: text.length
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                maximumLineCount: 16
            }
        }

        VerticalScrollDecorator { }
    }
}
