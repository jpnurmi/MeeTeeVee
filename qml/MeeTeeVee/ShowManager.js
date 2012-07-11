.pragma library

var instance = null;
var __models = {};
var __shows = {};

function getModel(showId) {
    return __models[showId];
}

function setModel(showId, model) {
    __models[showId] = model;
}

function getShows(showId) {
    if (showId in __shows)
        return __shows[showId];
    return [];
}

function resetShows(showId) {
    __shows[showId] = [];
}

function addShow(show) {
    var shows = __shows[show.showId];
    if (!shows)
        shows = [];
    shows.push(show);
    __shows[show.showId] = shows;
}

function removeShow(show) {
    var shows = __shows[show.showId];
    if (shows.length) {
        var idx = shows.indexOf(show);
        if (idx != -1) {
            shows.splice(idx, 1);
            __shows[show.showId] = shows;
        }
    }
}
