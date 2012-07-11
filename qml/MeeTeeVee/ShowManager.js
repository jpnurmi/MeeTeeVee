.pragma library

var instance = null;
var __shows = {};

function get(showId) {
    return __shows[showId];
}

function insert(showId, show) {
    __shows[showId] = show;
}

function remove(showId) {
    __shows[showId] = null;
}
