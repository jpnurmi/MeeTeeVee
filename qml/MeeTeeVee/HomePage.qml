import QtQuick 1.1
import com.nokia.meego 1.0
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
            subtitle: qsTr("Latest updates (2h)")
            logo: "images/tvr_logo.png"
        }

        model: XmlListModel {
            id: updatesModel
            source: "http://services.tvrage.com/feeds/last_updates.php?hours=2&sort=episodes"
            query: "/updates/show"
            XmlRole { name: "showid"; query: "id/string()" }
            XmlRole { name: "last"; query: "last/number()" }
            XmlRole { name: "lastepisode"; query: "lastepisode/string()" }
        }

        delegate: ListItem {
            title: showModel.name
            subtitle: showModel.summary
            thumbnailVisible: true
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
    }

    Component {
        id: showPage
        ShowPage { }
    }
}
