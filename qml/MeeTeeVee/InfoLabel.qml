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
import "UIConstants.js" as UI

Label {
    id: root

    property string title
    property string value

    visible: value.length
    width: parent ? parent.width : 0
    font.family: UI.FONT_FAMILY
    font.pixelSize: UI.SMALL_FONT
    textFormat: Text.RichText
    text: qsTr("<font color=\"%1\">%2:</font> <strong><font color=\"%3\">%4</font></strong>").arg(UI.SUBTITLE_COLOR).arg(title).arg(UI.TITLE_COLOR).arg(value)
}
