import QtQuick 2.9
import Qt.labs.platform 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ListView {
    id: listView
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
            visible: !listView.atYBeginning
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

    model: 10

    delegate: ItemDelegate {
        text: qsTr("Title %1").arg(index + 1)
        width: parent.width
    }

    ScrollIndicator.vertical: ScrollIndicator { }
}