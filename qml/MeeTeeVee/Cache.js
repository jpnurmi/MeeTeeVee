.pragma library

var db = null;

function initialize() {
    db = openDatabaseSync("MeeTeeVee", "1.0", "Cache", 4096);
    db.transaction(
        function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS ShowNames(showId TEXT UNIQUE, showName TEXT)");
        }
    )
}

function showName(id, name) {
    if (name.length) {
        db.transaction(
            function(tx) {
                var rs = tx.executeSql("UPDATE ShowNames SET showName=\"" + name + "\" WHERE showId='" + id + "'");
                if (rs.rowsAffected <= 0)
                    tx.executeSql("INSERT INTO ShowNames VALUES (?, ?)", [id, name]);
            }
        )
    } else {
        db.readTransaction(
            function(tx) {
                var rs = tx.executeSql("SELECT showName FROM ShowNames WHERE showId='" + id + "'");
                if (rs.rows.length)
                    name = rs.rows.item(0).showName;
            }
        )
    }
    return name;
}
