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
.pragma library

var __db = null;

function __open() {
    if (!__db) {
        __db = openDatabaseSync("MeeTeeVee", "1.0", "Settings", 1024);
        __db.transaction(
            function(tx) {
                tx.executeSql("CREATE TABLE IF NOT EXISTS Settings(key TEXT UNIQUE, value TEXT)");
            }
        )
    }
    return __db;
}

function read(key) {
    var value = undefined;
    __db = __open();
    __db.readTransaction(
        function(tx) {
            var rs = tx.executeSql("SELECT value FROM Settings WHERE key=?", [key]);
            if (rs.rows.length)
                value = rs.rows.item(0).value;
        }
    )
    return value;
}

function write(key, value) {
    __db.transaction(
        function(tx) {
            var rs = tx.executeSql("UPDATE Settings SET value=? WHERE key=?", [value, key]);
            if (rs.rowsAffected <= 0)
                tx.executeSql("INSERT INTO Settings VALUES (?, ?)", [key, value]);
        }
    )
}
