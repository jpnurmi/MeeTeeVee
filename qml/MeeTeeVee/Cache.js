.pragma library

var __db = null;
var __tables = ["ShowNames", "ShowImages", "ShowSummaries", "ShowGenres", "ShowDescriptions", "LatestEpisodes", "LatestAirdates"];

function showName(id, name) {
    return __getValue("ShowNames", id, name);
}

function showImage(id, image) {
    return __getValue("ShowImages", id, image);
}

function showSummary(id, summary) {
    return __getValue("ShowSummaries", id, summary);
}

function showGenres(id, genres) {
    return __getValue("ShowGenres", id, genres);
}

function showDescription(id, description) {
    return __getValue("ShowDescriptions", id, description);
}

function latestEpisode(id, episode) {
    return __getValue("LatestEpisodes", id, episode);
}

function latestAirdate(id, airdate) {
    return __getValue("LatestAirdates", id, airdate);
}

function __open() {
    if (!__db) {
        __db = openDatabaseSync("MeeTeeVee", "1.0", "Cache", 4096);
        __db.transaction(
            function(tx) {
                for (var i = 0; i < __tables.length; ++i)
                    tx.executeSql("CREATE TABLE IF NOT EXISTS " + __tables[i] + "(id TEXT UNIQUE, value TEXT)");
            }
        )
    }
    return __db;
}

function __getValue(scope, id, value) {
    __db = __open();
    if (value.length) {
        __db.transaction(
            function(tx) {
                var rs = tx.executeSql("UPDATE " + scope + " SET value=? WHERE id=?", [value, id]);
                if (rs.rowsAffected <= 0)
                    tx.executeSql("INSERT INTO " + scope + " VALUES (?, ?)", [id, value]);
            }
        )
    } else {
        __db.readTransaction(
            function(tx) {
                var rs = tx.executeSql("SELECT value FROM " + scope + " WHERE id=?", [id]);
                if (rs.rows.length)
                    value = rs.rows.item(0).value;
            }
        )
    }
    return value;
}
