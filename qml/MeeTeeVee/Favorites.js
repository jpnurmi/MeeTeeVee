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
.pragma library

var observers = [];

function registerObserver(observer) {
    observers.push(observer);
}

function unregisterObserver(observer) {
    var idx = observers.indexOf(observer);
    if (idx != -1)
        observers.splice(idx, 1);
}

function setFavorited(showId, favorited) {
    for (var i = 0; i < observers.length; ++i) {
        var observer = observers[i];
        if (observer.showId == showId)
            observer.favorited = favorited;
    }
}
