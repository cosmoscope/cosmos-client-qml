import QtQuick 2.9
import Qt.labs.platform 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ListView {
    id: dataListView
    anchors.fill: parent

    headerPositioning: ListView.OverlayHeader

    header: Pane {
        id: header
        z: 2
        width: parent.width

        contentHeight: 25

        SearchBar { }

        MenuSeparator {
            parent: header
            width: parent.width
            anchors.verticalCenter: parent.bottom
            visible: !dataListView.atYBeginning
        }
    }

    footer: ItemDelegate {
        id: footer
        text: qsTr("Footer")
        width: parent.width

        MenuSeparator {
            parent: footer
            width: parent.width
            anchors.verticalCenter: parent.top
        }
    }

    Component {
        id: listDataDelegate
        Rectangle {
            id: wrapper
            width: parent.width
            height: contactInfo.height
            color: dataListView.isCurrentItem ? "black" : "red"

            Text {
                id: contactInfo
                text: model.name
                color: wrapper.dataListView.isCurrentItem ? "red" : "black"
            }
        }
    }

    delegate: listDataDelegate

    ScrollIndicator.vertical: ScrollIndicator { }
}