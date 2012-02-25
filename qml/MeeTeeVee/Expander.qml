import QtQuick 1.1

Item {
    id: root

    property bool expanded: false
    property int duration: 250
    property real preferredHeight: 0
    default property alias data: container.data

    clip: true
    height: (expanded ? container.height : container.minimumHeight) + arrow.height

    Behavior on height { NumberAnimation { duration: root.duration; easing.type: Easing.InCubic } }

    Item {
        id: container

        property real minimumHeight: Math.min(root.preferredHeight, height)

        width: parent.width
        height: childrenRect.height
    }

    Image {
        source: "images/bottom-shadow.png"
        fillMode: Image.TileHorizontally
        opacity: arrow.y < container.height ? 1.0 : 0.0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: rectangle.top

        Behavior on opacity { NumberAnimation { duration: root.duration / 4; easing.type: Easing.OutCubic } }
    }

    Rectangle {
        id: rectangle
        color: "black"
        anchors.top: arrow.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: arrow.bottom
    }

    Image {
        id: arrow
        source: "images/arrow.png"
        height: visible ? implicitHeight : 0
        visible: container.height > preferredHeight
        rotation: expanded ? -180 : 0
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        Behavior on rotation { NumberAnimation { duration: root.duration; easing.type: Easing.InCubic } }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.expanded = !root.expanded
    }
}
