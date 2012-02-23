import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI
import "Model"

Page {
    id: root

//    Component {
//        id: seriesPage
//        SeriesPage { }
//    }

    SearchModel {
        id: searchModel
        keyword: searchBox.text
    }

    Text {
        anchors.centerIn: listView
        text: qsTr("No results")
        visible: listView.count <= 0
        font.family: UI.FONT_FAMILY_LIGHT
        font.pixelSize: UI.HUGE_FONT
        color: UI.INFO_COLOR
    }

    SearchBox {
        id: searchBox
        placeholderText: qsTr("Search")
        busy: searchModel.status === XmlListModel.Loading
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
    }

    ListView {
        id: listView
        clip: true
        model: searchModel
        anchors {
            top: searchBox.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: UI.SMALL_SPACING
        }
        delegate: SearchDelegate {
            title: SeriesName
            subtitle: Overview
            onClicked: {
//                var page = seriesPage.createObject(root.pageStack);
//                page.seriesId = seriesid;
//                root.pageStack.push(page);
            }
        }
    }

    Image {
        id: shadow
        width: parent.width
        anchors.top: searchBox.bottom
        source: "images/top-shadow.png"
        fillMode: Image.TileHorizontally
    }
}
