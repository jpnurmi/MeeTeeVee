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
