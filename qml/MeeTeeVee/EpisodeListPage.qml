import QtQuick 1.1

CommonPage {
    id: root

    property string title
    property string subtitle
    property alias model: listView.model

    busy: model.status === XmlListModel.Loading
    placeholder: busy ? qsTr("Loading...") : listView.count <= 0 ? qsTr("No episodes") : ""

    flickable: ListView {
        id: listView

        cacheBuffer: 4000

        header: Header {
            title: root.title
            subtitle: qsTr("Season %1").arg(root.model.season)
        }

        delegate: EpisodeDelegate {
            title: name
            subtitle: summary
            onClicked: {
                var page = episodeInfoPage.createObject(root, {showId: root.model.showId, number: root.model.season + "x" + episode});
                pageStack.push(page);
                // TODO: root.showed(showid);
            }
        }
    }

    Component {
        id: episodeInfoPage
        EpisodeInfoPage { }
    }
}
