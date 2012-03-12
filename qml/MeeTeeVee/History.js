function restore() {
    var history = [];
    var db = __open();
    db.transaction(
        function(tx) {
            var rs = tx.executeSql("SELECT * FROM History");
            for (var i = 0; i < rs.rows.length; ++i)
                history.push(rs.rows.item(i).showId);
        }
    )
    return history;
}

function save(history) {
    var db = __open();
    db.transaction(
        function(tx) {
            tx.executeSql("DELETE FROM History");
            for (var i = 0; i < history.length; ++i)
                tx.executeSql("INSERT INTO History VALUES (?)", [history[i]]);
        }
    )
}

function __open() {
    var db = openDatabaseSync("MeeTeeVee", "1.0", "History", 2048);
    db.transaction(
        function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS History(showId TEXT UNIQUE)");
        }
    )
    return db;
}
