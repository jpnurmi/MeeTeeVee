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
.import QtQuick.LocalStorage 2.0

var CREATE_TABLE_SQL = "CREATE TABLE IF NOT EXISTS Settings(key TEXT PRIMARY KEY ON CONFLICT REPLACE, value TEXT)";

function read(key) {
    var value = undefined;
    var db = LocalStorage.openDatabaseSync("MeeTeeVee", "1.0", "Settings", 1024);
    db.transaction(
        function(tx) {
            tx.executeSql(CREATE_TABLE_SQL);
            var rs = tx.executeSql("SELECT value FROM Settings WHERE key=?", [key]);
            if (rs.rows.length)
                value = rs.rows.item(0).value;
        }
    )
    return value;
}

function write(key, value) {
    var db = LocalStorage.openDatabaseSync("MeeTeeVee", "1.0", "Settings", 1024);
    db.transaction(
        function(tx) {
            tx.executeSql(CREATE_TABLE_SQL);
            tx.executeSql("INSERT OR REPLACE INTO Settings VALUES (?, ?)", [key, value]);
        }
    )
}
