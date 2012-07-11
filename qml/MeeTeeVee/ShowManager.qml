import QtQuick 1.1
import "ShowManager.js" as Manager

QtObject {
    id: root

    function getShow(showId) {
        var show = Manager.get(showId);
        if (!show)
            show = component.createObject(root, {showId: showId});
        return show;
    }

    property Component component: Component {
        id: component
        Show {
            id: object
            Component.onCompleted: Manager.insert(showId, object)
            Component.onDestruction: Manager.remove(showId, object)
        }
    }

    Component.onCompleted: Manager.instance = root
}
