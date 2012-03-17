import QtQuick 1.1
import com.nokia.meego 1.0

TextField {
    id: root

    property bool busy: false

    style: TextFieldStyle { paddingRight: loader.width }

    Loader {
        id: loader
        anchors.right: parent.right
        anchors.rightMargin: sourceComponent !== clearIcon ? 12 : 0
        anchors.verticalCenter: parent.verticalCenter
        sourceComponent: root.busy ? busyIndicator : root.text.length || root.platformPreedit.length ? clearIcon : searchIcon

        Component {
            id: searchIcon
            Image {
                width: 32
                height: 32
                smooth: true
                source: "image://theme/icon-m-toolbar-search"
            }
        }

        Component {
            id: busyIndicator
            BusyIndicator {
                running: true
                style: BusyIndicatorStyle {
                    inverted: false
                    size: "small"
                }
            }
        }

        Component {
            id: clearIcon
            Image {
                smooth: true
                source: "image://theme/icon-m-input-clear"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        inputContext.reset();
                        root.text = "";
                    }
                }
            }
        }
    }
}
