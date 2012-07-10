.pragma library

var __db = null;

function showName(id, name) {
    return __getValue("ShowNames", id, name);
}

function showImage(id, image) {
    return __getValue("ShowImages", id, image);
}

function __open() {
    if (!__db) {
        __db = openDatabaseSync("MeeTeeVee", "1.0", "Cache", 4096);
        __db.transaction(
            function(tx) {
                tx.executeSql("CREATE TABLE IF NOT EXISTS ShowNames(id TEXT UNIQUE, value TEXT)");
                tx.executeSql("CREATE TABLE IF NOT EXISTS ShowImages(id TEXT UNIQUE, value TEXT)");
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
                var rs = tx.executeSql("UPDATE " + scope + " SET value=\"" + value + "\" WHERE id='" + id + "'");
                if (rs.rowsAffected <= 0)
                    tx.executeSql("INSERT INTO " + scope + " VALUES (?, ?)", [id, value]);
            }
        )
    } else {
        __db.readTransaction(
            function(tx) {
                var rs = tx.executeSql("SELECT value FROM " + scope + " WHERE id='" + id + "'");
                if (rs.rows.length)
                    value = rs.rows.item(0).value;
            }
        )
    }
    return value;
}
