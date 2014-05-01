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

Row {
    id: row

    property alias title: title.text
    property alias value: value.text

    visible: !!value.text
    width: parent ? parent.width : 0
    spacing: Theme.paddingSmall

    Label {
        id: title
        font.pixelSize: Theme.fontSizeExtraSmall
        color: Theme.secondaryColor
    }

    Label {
        id: value
        width: row.width - row.spacing - title.width
        font.pixelSize: Theme.fontSizeExtraSmall
        color: Theme.primaryColor
        elide: Text.ElideRight
    }
}
