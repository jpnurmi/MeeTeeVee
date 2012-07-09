import QtQuick 1.1
import com.nokia.meego 1.0
import "Cache.js" as Cache
import "UIConstants.js" as UI

CommonPage {
    id: root

    signal showed(string showId)

    busy: updatesModel.status === XmlListModel.Loading
    placeholder: busy ? qsTr("Loading...") : listView.count <= 0 ? qsTr("No recent updates") : ""

    flickable: ListView {
        id: listView

        cacheBuffer: 4000

        header: Header {
            title: "MeeTeeVee"
            subtitle: qsTr("Recent updates")
            content: Image {
                source: "images/tvr_logo.png"
                opacity: logoArea.pressed && logoArea.containsMouse ? UI.DISABLED_OPACITY : 1.0
                MouseArea {
                    id: logoArea
                    anchors.fill: parent
                    onClicked: Qt.openUrlExternally("http://www.tvrage.com")
                }
            }
        }

        model: XmlListModel {
            id: updatesModel
            source: "http://services.tvrage.com/feeds/last_updates.php?&sort=episodes&hours=1"
            query: "/updates/show[position() < 11]"
            XmlRole { name: "showid"; query: "id/string()"; isKey: true }
            XmlRole { name: "last"; query: "last/number()" }
            XmlRole { name: "lastepisode"; query: "lastepisode/string()" }
        }

        delegate: ShowDelegate {
            title: Cache.showName(showid, showModel.name)
            subtitle: episodeModel.count === 1 ? qsTr("%1: %2").arg(episodeModel.get(0).number).arg(episodeModel.get(0).title) : ""
            description: episodeModel.count === 1 ? episodeModel.get(0).airdate : ""
            thumbnail: Cache.showImage(showid, showModel.image.toString())
            onClicked: {
                var page = showPage.createObject(root, {model: showModel});
                pageStack.push(page);
                root.showed(showid);
            }
            ShowModel {
                id: showModel
                showId: showid
            }
            XmlListModel {
                id: episodeModel
                source: "http://services.tvrage.com/feeds/episodeinfo.php?sid=" + showid
                query: "/show/latestepisode"
                XmlRole { name: "number"; query: "number/string()" }
                XmlRole { name: "title"; query: "title/string()" }
                XmlRole { name: "airdate"; query: "airdate/string()" }
            }
        }
    }

    Component {
        id: showPage
        ShowPage { }
    }
}
