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

StorageModel {
    id: root

    function addShow(showId) {
        for (var i = 0; i < count; ++i) {
            if (get(i).showid === showId) {
                move(i, 0, 1);
                return;
            }
        }

        insert(0, {"showid": showId});
        if (count > 10)
            remove(10, count - 10);
    }

    function removeShow(showId) {
        for (var i = 0; i < count; ++i) {
            if (get(i).showid === showId) {
                remove(i, 1);
                return;
            }
        }
    }

    Component.onCompleted: root.load("History")
    Component.onDestruction: root.save("History")
}
