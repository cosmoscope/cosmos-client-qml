import QtQuick 2.9
import Qt.labs.platform 1.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ListView {
    id: dataListView
    anchors.fill: parent

    headerPositioning: ListView.OverlayHeader

    header: Pane {
        id: header
        z: 2
        width: parent.width

        contentHeight: 18

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
                id: itemColorIcon
                anchors.left: parent.left
                width: 20; height: 20
                radius: width * 0.5
                color: model.item.color

                Connections {
                    target: model.item

                    onColorChanged: {
                        itemColorIcon.color = model.item.color;
                    }
                }
            }

            Text {
                id: itemText
                Layout.fillWidth: true
                text: model.item.name
                elide: Text.ElideRight
            }

            ToolButton {
                id: itemToolButton
                anchors.right: parent.right
                width: 20

                text: qsTr("⋮")
                font.pointSize: 20

                background: Rectangle {
                    color: itemToolButton.down ? "#d6d6d6" : "transparent"
                }

                onClicked: itemContextMenu.popup()
            }
        }

        Menu {
            id: itemContextMenu

            Action {
                text: "Visible"
                checkable: true
                checked: true

                onToggled: {
                    model.item.visible = checked;
                    model.item.visibilityChanged(checked);
                }
            }
            Action {
                text: "Change Color"
                onTriggered: colorDialog.open()
            }

            ColorDialog {
                id: colorDialog
                title: "Please choose a color"

                onAccepted: {
                    model.item.color = colorDialog.color;
                    model.item.colorChanged(colorDialog.color);
                }

                onRejected: {
                    console.log("Canceled")
                }
            }

            MenuSeparator { }

            Action {
                text: "Delete"

                onTriggered: dataListView.model.removeRow(currentIndex)
            }

            Menu {
                title: "Find/Replace"
                Action { text: "Find Next" }
                Action { text: "Find Previous" }
                Action { text: "Replace" }
            }
        }

        MouseArea {
            anchors.fill: parent
            anchors.rightMargin: itemToolButton.width
            onClicked: {
                dataListView.currentIndex = index;
            }
        }
    }

    ScrollIndicator.vertical: ScrollIndicator { }
}