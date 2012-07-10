import QtQuick 1.1

ListModel {
    id: root

    property string name: "Default"
    property int size: 2048
    property bool loaded: false
    property bool loading: false

    function load() {
        loading = true;
        var db = __open();
        db.transaction(
            function(tx) {
                var rs = tx.executeSql("SELECT * FROM " + name);
                for (var i = 0; i < rs.rows.length; ++i)
                    append({"showid": rs.rows.item(i).showId});
            }
        )
        loading = false;
        loaded = true;
    }

    function save() {
        var db = __open();
        db.transaction(
            function(tx) {
                tx.executeSql("DELETE FROM " + name);
                for (var i = 0; i < count; ++i)
                    tx.executeSql("INSERT INTO " + name + " VALUES (?)", [get(i).showid]);
            }
        )
    }

    function __open() {
        var db = openDatabaseSync("MeeTeeVee", "1.0", name, size);
        db.transaction(
            function(tx) {
                tx.executeSql("CREATE TABLE IF NOT EXISTS " + name + "(showId TEXT UNIQUE)");
            }
        )
        return db;
    }

    Component.onDestruction: if (loaded) save()
}
