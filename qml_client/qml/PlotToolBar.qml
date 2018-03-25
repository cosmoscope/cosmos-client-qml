import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.platform 1.0

ToolBar {
    width: 30
    
    background: Rectangle {
        color: '#fafafa'
        // width: 1
    }

    ButtonGroup {
        buttons: selectionTools.children
    }

    ColumnLayout {
        id: selectionTools

        ToolButton {
            id: rectSelect
            checkable: true

            contentItem: Image {
                sourceSize.width: 20
                sourceSize.height: 20
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: "images/edit-tools/044-marquee.svg"
            }

            background: Rectangle {
                height: parent.height
                color: (rectSelect.down || rectSelect.checked) ? "#d6d6d6" : "transparent"
            }
        }

        ToolButton {
            id: zoomIn
            checkable: true
            checked: false

            contentItem: Image {
                sourceSize.width: 20
                sourceSize.height: 20
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: "images/edit-tools/049-zoom-in.svg"
            }

            background: Rectangle {
                height: parent.height
                color: (zoomIn.down || zoomIn.checked) ? "#d6d6d6" : "transparent"
            }
        }

        ToolButton {
            id: zoomOut
            checkable: true

            contentItem: Image {
                sourceSize.width: 20
                sourceSize.height: 20
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: "images/edit-tools/048-zoom-out.svg"
            }

            background: Rectangle {
                height: parent.height
                color: (zoomOut.down || zoomOut.checked) ? "#d6d6d6" : "transparent"
            }
        }

        ToolButton {
            id: pan
            checkable: true

            contentItem: Image {
                sourceSize.width: 20
                sourceSize.height: 20
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: "images/edit-tools/008-hold.svg"
            }

            background: Rectangle {
                height: parent.height
                color: (pan.down || pan.checked) ? "#d6d6d6" : "transparent"
            }
        }

        ToolSeparator {
            width: parent.width
            height: 1
            contentItem.visible: true //fileRow.y === editRow.y

            orientation: Qt.Horizontal
        }
    }
}