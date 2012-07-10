.pragma library

var __db = null;
var __tables = ["name","link","seasons","image","started","ended",
                "country","status","classification","summary","genres",
                "runtime","network","airtime","airday","timezone"];

function __open() {
    if (!__db) {
        __db = openDatabaseSync("MeeTeeVee", "1.0", "ShowCache", 4096);
        __db.transaction(
            function(tx) {
                for (var i = 0; i < __tables.length; ++i)
                    tx.executeSql("CREATE TABLE IF NOT EXISTS " + __tables[i] + "(id TEXT UNIQUE, value TEXT)");
            }
        )
    }
    return __db;
}

function read(scope, id) {
    var value = "";
    __db = __open();
    __db.readTransaction(
        function(tx) {
            var rs = tx.executeSql("SELECT value FROM " + scope + " WHERE id=?", [id]);
            if (rs.rows.length)
                value = rs.rows.item(0).value;
        }
    )
    return value;
}

function write(scope, id, value) {
    __db = __open();
    __db.transaction(
        function(tx) {
            var rs = tx.executeSql("UPDATE " + scope + " SET value=? WHERE id=?", [value, id]);
            if (rs.rowsAffected <= 0)
                tx.executeSql("INSERT INTO " + scope + " VALUES (?, ?)", [id, value]);
        }
    )
}
