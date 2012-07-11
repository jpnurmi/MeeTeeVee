var items = {};

function value(key) {
    return items[key];
}

function insert(key, value) {
    items[key] = value;
}

function remove(key) {
    items[key] = undefined;
}
