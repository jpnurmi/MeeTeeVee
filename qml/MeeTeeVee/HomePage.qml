import QtQuick 1.1
import com.nokia.meego 1.0
import "Cache.js" as Cache
import "UIConstants.js" as UI

CommonPage {
    id: root

    signal showed(string showId)

    busy: updatesModel.status === XmlListModel.Loading
    placeholder: busy ? qsTr("Loading...") : listView.count <= 0 ? qsTr("No updates") : ""

    flickable: ListView {
        id: listView

        cacheBuffer: 4000

        header: Header {
            title: "MeeTeeVee"
            subtitle: qsTr("Latest updates (%1h)").arg(updatesModel.hours)
            logo: "images/tvr_logo.png"
        }

        model: XmlListModel {
            id: updatesModel
            property int hours: 2
            source: "http://services.tvrage.com/feeds/last_updates.php?&sort=episodes&hours=" + hours
            query: "/updates/show"
            XmlRole { name: "showid"; query: "id/string()"; isKey: true }
            XmlRole { name: "last"; query: "last/number()" }
            XmlRole { name: "lastepisode"; query: "lastepisode/string()" }
        }

        delegate: ShowDelegate {
            title: Cache.showName(showid, showModel.name)
            subtitles: showModel.subtitles()
            stamp: {
                var mins = Math.max(0, Math.round(last / 60));
                if (mins >= 60)
                    return qsTr("%1h").arg(Math.round(mins / 60));
                return qsTr("%1m").arg(mins);
            }
            thumbnail: showModel.image
            onClicked: {
                var page = showPage.createObject(root, {model: showModel});
                pageStack.push(page);
                root.showed(showid);
            }
            ShowModel {
                id: showModel
                showId: showid
            }
        }

        footer: ToolButton{
            text: qsTr("More...")
            anchors.right: parent.right
            enabled: updatesModel.status === XmlListModel.Ready
            visible: updatesModel.status === XmlListModel.Ready || updatesModel.count > 0
            onClicked: updatesModel.hours += 1
        }
    }

    Component {
        id: showPage
        ShowPage { }
    }
}
