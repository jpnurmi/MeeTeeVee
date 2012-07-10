.pragma library

var showModels = [];

function addShowModel(model) {
    showModels.push(model);
}

function removeShowModel(model) {
    var idx = showModels.indexOf(model);
    if (idx != -1)
        showModels.splice(idx, 1);
}
