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
            id: delegate
            property string seasonNumber: root.model.season < 10 ? "0" + root.model.season : root.model.season
            property string episodeNumber: episode < 10 ? "0" + episode : episode
            title: qsTr("%1: %2").arg(seasonNumber + "x" + episodeNumber).arg(name)
            subtitle: model.airdate
            rating: model.rating
            hasSummary: model.summary != ""
            hasScreencap: model.screencap != ""
            enabled: hasSummary || hasScreencap
            onClicked: {
                var page = episodePage.createObject(root, {title: delegate.title, summary: model.summary, screencap: model.screencap});
                pageStack.push(page);
                // TODO: root.showed(showid);
            }
        }
    }

    Component {
        id: episodePage
        EpisodePage { }
    }
}
