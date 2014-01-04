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

Dialog {
    SilicaListView {
        anchors.fill: parent

        spacing: Theme.paddingLarge

        header: DialogHeader { title: qsTr("About") }

        model: VisualItemModel {

            PageHeader {
                title: qsTr("%1 %2").arg(Qt.application.name).arg(Qt.application.version)
            }

            Label {
                wrapMode: Text.WordWrap
                anchors { left: parent.left; right: parent.right; margins: Theme.paddingLarge }
                font.pixelSize: Theme.fontSizeMedium
                text: qsTr("A TV show guide for Sailfish")
            }

            Label {
                wrapMode: Text.WordWrap
                anchors { left: parent.left; right: parent.right; margins: Theme.paddingLarge }
                font.pixelSize: Theme.fontSizeSmall
                text: qsTr("Browse and track your favourite TV shows and episodes.")
            }

            Label {
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                anchors { left: parent.left; right: parent.right; margins: Theme.paddingLarge }
                font.pixelSize: Theme.fontSizeSmall
                text: qsTr("(C) 2014 J-P Nurmi &lt;<a style='color:%1' href=\"mailto:jpnurmi@gmail.com\">jpnurmi@gmail.com</a>&gt;").arg(Theme.highlightColor)
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Image {
                source: "images/banner.jpg"
                anchors { horizontalCenter: parent.horizontalCenter }
            }

            Label {
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                anchors { left: parent.left; right: parent.right; margins: Theme.paddingLarge }
                font.pixelSize: Theme.fontSizeSmall
                text: qsTr("<p><a style='color:%1' href='http://www.tvrage.com'>TVRage.com</a> has information from over 29,000 shows and 1 million episodes in its database. Because of their user friendly contribution sections, members can easily update information such as summaries, air dates, titles, and more, regarding shows and episodes.</p>" +
                           "<p><small>This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.</small></p>" +
                           "<p><small>This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.</small></p>")
                           .arg(Theme.highlightColor)
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }

        VerticalScrollDecorator { }
    }
}
