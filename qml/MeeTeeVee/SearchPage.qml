import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Page {
    id: root

    Text {
        parent: listView.contentItem
        anchors.centerIn: parent
        text: qsTr("No results")
        visible: listView.count <= 0
        font.family: UI.FONT_FAMILY_LIGHT
        font.pixelSize: UI.HUGE_FONT
        color: UI.INFO_COLOR
    }

    ListView {
        id: listView

        anchors.fill: parent

        header: SearchBox {
            id: searchBox
            placeholderText: qsTr("Search")
            busy: searchModel.status === XmlListModel.Loading
            anchors.left: parent.left
            anchors.right: parent.right
            onTextChanged: searchModel.showName = text
            Keys.onEnterPressed: { closeSoftwareInputPanel(); parent.forceActiveFocus(); }
            Keys.onReturnPressed: { closeSoftwareInputPanel(); parent.forceActiveFocus(); }
        }

        model: SearchModel {
            id: searchModel
        }

        delegate: SearchDelegate {
            title: name
            subtitle: link
            onClicked: Qt.openUrlExternally(link)
        }
    }

    ScrollDecorator {
        flickableItem: listView
        anchors.topMargin: 52 + Math.abs(Math.min(0, listView.contentY))
    }
}
