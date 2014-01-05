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
import QtQuick.XmlListModel 2.0

XmlListModel {
    id: root

    source: "http://services.tvrage.com/feeds/last_updates.php?&sort=episodes&hours=1"
    query: "/updates/show[position() < 11]"

    XmlRole { name: "showid"; query: "id/string()"; isKey: true }
    XmlRole { name: "last"; query: "last/number()" }
    XmlRole { name: "lastepisode"; query: "lastepisode/string()" }
}
