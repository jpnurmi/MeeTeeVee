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
var items = {};

function values(key) {
    if (key in items)
        return items[key];
    return [];
}

function insert(key, value) {
    var v = values(key);
    v.push(value);
    items[key] = v;
}

function remove(key, value) {
    if (value === undefined) {
        items[key] = [];
    } else {
        var v = values(key);
        var i = v.indexOf(value);
        if (i != -1) {
            v.splice(i, 1);
            items[key] = v;
        }
    }
}
