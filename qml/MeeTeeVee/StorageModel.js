function __open(name) {
    var db = openDatabaseSync("MeeTeeVee", "1.0", name, 2048);
    db.transaction(
        function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS " + name + "(showId TEXT UNIQUE)");
        }
    )
    return db;
}

function __load(name, model) {
    var db = __open();
    db.transaction(
        function(tx) {
            var rs = tx.executeSql("SELECT * FROM " + name);
            for (var i = 0; i < rs.rows.length; ++i)
                model.append({"showid": rs.rows.item(i).showId});
        }
    )
}

function save(name, model) {
    var db = __open();
    db.transaction(
        function(tx) {
            tx.executeSql("DELETE FROM " + name);
            for (var i = 0; i < model.count; ++i)
                tx.executeSql("INSERT INTO " + name + " VALUES (?)", [model.get(i).showid]);
        }
    )
}

WorkerScript.onMessage = function(msg) {
    var start = new Date();
    __load(msg.name, msg.model);
    var end = null;
    do { end = new Date(); } while (end - start < 500);
    msg.model.sync();
    WorkerScript.sendMessage({});
}
