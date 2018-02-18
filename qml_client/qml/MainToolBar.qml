import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.platform 1.0

ToolBar {
    leftPadding: 8

    z: 1
    width: parent.width
    parent: window.overlay

    ModelingDialog {
        id: modelingDialog
    }

    Flow {
        id: flow
        width: parent.width

        Row {
            id: fileRow

            ToolButton {
                id: openButton
            //    font.family: localFont.name
               onClicked: modelingDialog.open()

                contentItem: Image {
                    sourceSize.width: 40
                    sourceSize.height: 40
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/open.png"
                }
            }

            ToolButton {
                id: newButton
//                font.family: localFont.name
//                onClicked: openDialog.open()

                contentItem: Image {
                    sourceSize.width: 40
                    sourceSize.height: 40
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/new.png"
                }
            }

            ToolButton {
                id: saveButton
//                font.family: localFont.name
//                onClicked: openDialog.open()

                contentItem: Image {
                    sourceSize.width: 40
                    sourceSize.height: 40
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/save.png"
                }
            }

            ToolSeparator {
                contentItem.visible: fileRow.y === editRow.y
            }
        }

        Row {
            id: editRow

            ToolButton {
                id: copyButton
                focusPolicy: Qt.TabFocus
//                enabled: textArea.selectedText
//                onClicked: textArea.copy()

                contentItem: Image {
                    sourceSize.width: 40
                    sourceSize.height: 40
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
                }
            }

            ToolSeparator {
                contentItem.visible: editRow.y === formatRow.y
            }
        }

        Row {
            id: formatRow

            ToolButton {
                id: boldButton
//                text: "\uE800" // icon-bold
//                font.family: localFont.name
                focusPolicy: Qt.TabFocus
                checkable: true
//                checked: document.bold
//                onClicked: document.bold = !document.bold

                contentItem: Image {
                    sourceSize.width: 40
                    sourceSize.height: 40
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
                }
            }

            ToolSeparator {
                contentItem.visible: formatRow.y === alignRow.y
            }
        }

        Row {
            id: alignRow

            ToolButton {
                id: alignLeftButton
//                font.family: localFont.name
                focusPolicy: Qt.TabFocus
                checkable: true
//                checked: document.alignment == Qt.AlignLeft
//                onClicked: document.alignment = Qt.AlignLeft

                contentItem: Image {
                    sourceSize.width: 40
                    sourceSize.height: 40
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
                }
            }
        }
    }
}