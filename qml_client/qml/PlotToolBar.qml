import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.platform 1.0

ToolBar {
    // leftPadding: 8
    // height: parent.height
    background: Rectangle {
        color: 'white'
    }

    ColumnLayout {
        // id: fileRow

        ToolButton {
            // id: openButton
        //    font.family: localFont.name
            contentItem: Image {
                sourceSize.width: 30
                sourceSize.height: 30
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: "images/folder-7.svg"
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