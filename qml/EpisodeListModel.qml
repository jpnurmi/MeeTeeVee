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
import QtQuick.XmlListModel 2.0

XmlListModel {
    id: root

    property string season
    property bool busy: !xml || status == XmlListModel.Loading

    query: "/Show/Episodelist/Season[@no='"+season+"']/episode"

    XmlRole { name: "name"; query: "title/string()" }
    XmlRole { name: "summary"; query: "summary/string()" }
    XmlRole { name: "episode"; query: "seasonnum/number()" }
    XmlRole { name: "airdate"; query: "airdate/string()" }
    XmlRole { name: "link"; query: "link/string()" }
    XmlRole { name: "rating"; query: "rating/string()" }
    XmlRole { name: "screencap"; query: "screencap/string()" }
    XmlRole { name: "section"; query: "0" }
}
