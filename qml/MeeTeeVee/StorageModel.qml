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
import QtQuick 2.1
import "StorageModel.js" as Model

ListModel {
    id: root

    property bool loaded: false
    property bool loading: false

    function load(name) {
        if (!loading && !loaded && name) {
            loading = true;
            worker.sendMessage({model: root, name: name});
        }
    }

    function save(name) {
        if (loaded)
            Model.save(name, root);
    }

    property WorkerScript worker: WorkerScript {
        id: worker
        source: "StorageModel.js"
        onMessage: {
            root.loading = false;
            root.loaded = true;
        }
    }
}
