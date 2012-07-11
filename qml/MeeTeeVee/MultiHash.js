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
