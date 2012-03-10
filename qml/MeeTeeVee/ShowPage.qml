import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Page {
    id: root

    property ShowModel model

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: parent.width
            spacing: UI.MEDIUM_SPACING

            Label {
                text: root.model ? root.model.name : ""
                width: parent.width
                font.family: UI.FONT_FAMILY
                font.pixelSize: UI.LARGE_FONT
                font.weight: Font.Bold
                textFormat: Text.PlainText
            }

            Image {
                source: root.model ? root.model.image : ""
            }

            Grid {
                id: grid
                columns: 2

                property real contentWidth: parent.width - classification.width

                Label {
                    id: classification
                    text: qsTr("Classification: ")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    font.weight: Font.Bold
                    textFormat: Text.PlainText
                }
                Label {
                    text: root.model && root.model.classification.length ? root.model.classification : qsTr("-")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    textFormat: Text.PlainText
                    width: grid.contentWidth
                }

                Label {
                    text: qsTr("Genre: ")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    font.weight: Font.Bold
                    textFormat: Text.PlainText
                }
                Label {
                    text: root.model && root.model.genres.length ? root.model.genres : qsTr("-")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    textFormat: Text.PlainText
                    width: grid.contentWidth
                }

                Label {
                    text: qsTr("Status: ")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    font.weight: Font.Bold
                    textFormat: Text.PlainText
                }
                Label {
                    text: root.model && root.model.showStatus.length ? root.model.showStatus : qsTr("-")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    textFormat: Text.PlainText
                    width: grid.contentWidth
                }

                Label {
                    text: qsTr("Network: ")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    font.weight: Font.Bold
                    textFormat: Text.PlainText
                }
                Label {
                    text: root.model && root.model.network.length ? root.model.network : qsTr("-")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    textFormat: Text.PlainText
                    width: grid.contentWidth
                }

                Label {
                    text: qsTr("Airs: ")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    font.weight: Font.Bold
                    textFormat: Text.PlainText
                }
                Label {
                    function airs(airday, airtime) {
                        if (airday.length && airtime.length)
                            return qsTr("%1s at %2").arg(airday).arg(airtime);
                        if (airday.length)
                            return qsTr("%1s").arg(airday);
                        if (airtime.length)
                            return airtime;
                        return qsTr("-");
                    }
                    text: root.model ? airs(root.model.airday, root.model.airtime) : ""
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    textFormat: Text.PlainText
                    width: grid.contentWidth
                }

                Label {
                    text: qsTr("Runtime: ")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    font.weight: Font.Bold
                    textFormat: Text.PlainText
                }
                Label {
                    text: root.model && root.model.runtime > 0 ? qsTr("%1 minutes").arg(root.model.runtime) : qsTr("-")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    textFormat: Text.PlainText
                    width: grid.contentWidth
                }

                Label {
                    text: qsTr("Premiere: ")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    font.weight: Font.Bold
                    textFormat: Text.PlainText
                }
                Label {
                    text: root.model && root.model.started.length ? root.model.started : qsTr("-")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    textFormat: Text.PlainText
                    width: grid.contentWidth
                }

                Label {
                    text: qsTr("Ended: ")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    font.weight: Font.Bold
                    textFormat: Text.PlainText
                }
                Label {
                    text: root.model && root.model.ended.length ? root.model.ended : qsTr("-")
                    font.family: UI.FONT_FAMILY
                    font.pixelSize: UI.MEDIUM_FONT
                    textFormat: Text.PlainText
                    width: grid.contentWidth
                }
            }

            ListItem {
                title: qsTr("Seasons and episodes")
                subtitle: root.model ? qsTr("%1 seasons").arg(root.model.seasons) : ""
                onClicked: console.log("TODO...")
            }

            ListItem {
                title: qsTr("Open TVRage.com")
                subtitle: root.model ? root.model.link : ""
                onClicked: Qt.openUrlExternally(root.model.link)
            }
        }
    }

    ScrollDecorator {
        flickableItem: flickable
    }
}
