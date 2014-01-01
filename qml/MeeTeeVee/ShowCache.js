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

var CREATE_TABLE_SQL = "CREATE TABLE IF NOT EXISTS Shows(showId TEXT PRIMARY KEY ON CONFLICT REPLACE, name TEXT,"
                                                      + "link TEXT, seasons TEXT, image TEXT, started TEXT, ended TEXT,"
                                                      + "country TEXT, status TEXT, classification TEXT, summary TEXT, genres TEXT,"
                                                      + "runtime TEXT, network TEXT, airtime TEXT, airday TEXT, timezone TEXT)"

function readCache(showId) {
    var data = {};
    var db = LocalStorage.openDatabaseSync("MeeTeeVee", "1.0", "ShowCache", 4096);
    db.transaction(
        function(tx) {
            tx.executeSql(CREATE_TABLE_SQL)
            var rs = tx.executeSql("SELECT * FROM Shows WHERE showId=?", [showId]);
            if (rs.rows.length)
                data = rs.rows.item(0);
        }
    );
    return data;
}

function writeCache(data) {
    var db = LocalStorage.openDatabaseSync("MeeTeeVee", "1.0", "ShowCache", 4096);
    db.transaction(
        function(tx) {
            tx.executeSql(CREATE_TABLE_SQL)
            tx.executeSql("INSERT OR REPLACE INTO Shows VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                          [data.showId, data.name, data.link, data.seasons, data.image, data.started, data.ended,
                           data.country, data.status, data.classification, data.summary, data.genres, data.runtime,
                           data.network, data.airtime, data.airday, data.timezone]);
        }
    );
}

WorkerScript.onMessage = function(msg) {
    if (msg.operation == "read") {
        var data = readCache(msg.showId);
        if (data.showId)
            WorkerScript.sendMessage(data);
    } else  {
        writeCache(msg);
    }
}
