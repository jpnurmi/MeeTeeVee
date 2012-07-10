import QtQuick 1.1
import "StorageModel.js" as Model

ListModel {
    id: root

    property string name: "Default"
    property bool loaded: false
    property bool loading: false

    function load() {
        loading = true;
        worker.sendMessage({model: root, name: name});
    }

    property WorkerScript worker: WorkerScript {
        id: worker
        source: "StorageModel.js"
        onMessage: {
            root.loading = false;
            root.loaded = true;
        }
    }

    Component.onDestruction: if (loaded) Model.save(name, root)
}
