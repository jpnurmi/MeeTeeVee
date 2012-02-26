import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI
import "models"

Page {
    id: root

    property string seriesId

    width: parent.width
    height: listView.height

    onStatusChanged: {
        if (status === PageStatus.Activating) {
            model.seriesId = root.seriesId;
        }
    }

    BusyIndicator {
        visible: running
        running: model.status === XmlListModel.Loading
        style: BusyIndicatorStyle { size: "large" }
        anchors.centerIn: parent
    }

    ListView {
        id: listView
        width: parent.width
        height: count > 0 ? contentHeight : 0
        interactive: false
        model: SeasonsModel { id: model }
        delegate: Item { }
        section.property: "SeasonNumber"
        section.delegate: SearchDelegate {
            title: qsTr("Season %1").arg(section)
            onClicked: {
                var page = seasonPage.createObject(root.pageStack);
                page.seriesId = root.seriesId;
                page.season = section;
                root.pageStack.push(page);
            }
        }
    }
}
