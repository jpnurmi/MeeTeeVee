/*
* Copyright (C) 2012 J-P Nurmi <jpnurmi@gmail.com>
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*/
function createTableSql(name) {
    return "CREATE TABLE IF NOT EXISTS " + name + "(showId TEXT PRIMARY KEY ON CONFLICT REPLACE)";
}

function __load(name, model) {
    var db = openDatabaseSync("MeeTeeVee", "1.0", name, 2048);
    db.transaction(
        function(tx) {
            tx.executeSql(createTableSql(name));
            var rs = tx.executeSql("SELECT * FROM " + name);
            for (var i = 0; i < rs.rows.length; ++i)
                model.append({"showid": rs.rows.item(i).showId});
        }
    )
}

function save(name, model) {
    var db = openDatabaseSync("MeeTeeVee", "1.0", name, 2048);
    db.transaction(
        function(tx) {
            tx.executeSql("DELETE FROM " + name);
            tx.executeSql(createTableSql(name));
            for (var i = 0; i < model.count; ++i)
                tx.executeSql("INSERT OR REPLACE INTO " + name + " VALUES (?)", [model.get(i).showid]);
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
