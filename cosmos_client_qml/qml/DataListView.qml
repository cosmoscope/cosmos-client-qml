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
            visible: !dataListView.atYEnding
        }
    }

    Pane {
        id: footer
        width: parent.width
        anchors.bottom: parent.bottom

        Text {
            text: "Here"
        }

        MenuSeparator {
            parent: footer
            width: parent.width
            anchors.verticalCenter: parent.top
        }
    }

    delegate: ItemDelegate {
        width: parent.width

        highlighted: ListView.isCurrentItem

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 5

            Rectangle {
                anchors.left: parent.left
                width: 20; height: 20
                radius: width * 0.5
                color: model.style.get(0).color
            }

            Text {
                id: itemText
                Layout.fillWidth: true
                text: model.name
                elide: Text.ElideRight
            }

            ToolButton {
                id: itemToolButton
                anchors.right: parent.right
                text: qsTr("⋮")
                font.pointSize: 20
                onClicked: {
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            anchors.rightMargin: itemToolButton.width
            onClicked: {
                dataListView.currentIndex = index;
                model.style.set(0, {'opacity': 1, 'color': 'purple'});
            }
        }
    }

    ScrollIndicator.vertical: ScrollIndicator { }
}