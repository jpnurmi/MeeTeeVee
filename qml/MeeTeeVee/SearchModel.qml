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

XmlListModel {
    id: root

    property string showName

    source: showName.length ? "http://services.tvrage.com/feeds/search.php?show=" + showName : ""
    query: "/Results/show"

    XmlRole { name: "showid"; query: "showid/string()" }
    XmlRole { name: "name"; query: "name/string()" }
    XmlRole { name: "link"; query: "link/string()" }
    XmlRole { name: "country"; query: "country/string()" }
    XmlRole { name: "started"; query: "started/string()" }
    XmlRole { name: "ended"; query: "ended/string()" }
    XmlRole { name: "seasons"; query: "seaons/number()" }
    XmlRole { name: "status"; query: "status/string()" }
    XmlRole { name: "classification"; query: "classification/string()" }
    XmlRole { name: "genres"; query: "string-join(genres/genre,', ')" }
}
