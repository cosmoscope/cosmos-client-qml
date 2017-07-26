import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.platform 1.0

ToolBar {
    leftPadding: 8

    Flow {
        id: flow
        width: parent.width

        Row {
            id: fileRow

            ToolButton {
                id: openButton
                font.family: localFont.name
                onClicked: openDialog.open()

                contentItem: Image {
                    sourceSize.width: 20
                    sourceSize.height: 20
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
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
                enabled: textArea.selectedText
                onClicked: textArea.copy()

                contentItem: Image {
                    sourceSize.width: 20
                    sourceSize.height: 20
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
                }
            }

            ToolButton {
                id: cutButton
                text: "\uE802" // icon-scissors
                font.family: localFont.name
                focusPolicy: Qt.TabFocus
                enabled: textArea.selectedText
                onClicked: textArea.cut()

                contentItem: Image {
                    sourceSize.width: 20
                    sourceSize.height: 20
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
                }
            }

            ToolButton {
                id: pasteButton
                text: "\uF0EA" // icon-paste
                font.family: localFont.name
                focusPolicy: Qt.TabFocus
                enabled: textArea.canPaste
                onClicked: textArea.paste()

                contentItem: Image {
                    sourceSize.width: 20
                    sourceSize.height: 20
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
                text: "\uE800" // icon-bold
                font.family: localFont.name
                focusPolicy: Qt.TabFocus
                checkable: true
                checked: document.bold
                onClicked: document.bold = !document.bold

                contentItem: Image {
                    sourceSize.width: 20
                    sourceSize.height: 20
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
                }
            }

            ToolButton {
                id: italicButton
                text: "\uE801" // icon-italic
                font.family: localFont.name
                focusPolicy: Qt.TabFocus
                checkable: true
                checked: document.italic
                onClicked: document.italic = !document.italic

                contentItem: Image {
                    sourceSize.width: 20
                    sourceSize.height: 20
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
                }
            }

            ToolButton {
                id: underlineButton
                text: "\uF0CD" // icon-underline
                font.family: localFont.name
                focusPolicy: Qt.TabFocus
                checkable: true
                checked: document.underline
                onClicked: document.underline = !document.underline

                contentItem: Image {
                    sourceSize.width: 20
                    sourceSize.height: 20
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
                }
            }

            ToolButton {
                id: fontFamilyToolButton
                text: qsTr("\uE808") // icon-font
                font.family: localFont.name
                font.bold: document.bold
                font.italic: document.italic
                font.underline: document.underline
                onClicked: {
                    fontDialog.currentFont.family = document.fontFamily;
                    fontDialog.currentFont.pointSize = document.fontSize;
                    fontDialog.open();
                }

                contentItem: Image {
                    sourceSize.width: 20
                    sourceSize.height: 20
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
                }
            }

            ToolButton {
                id: textColorButton
                font.family: localFont.name
                focusPolicy: Qt.TabFocus
                onClicked: colorDialog.open()

                Rectangle {
                    width: aFontMetrics.width + 3
                    height: 2
                    color: document.textColor
                    parent: textColorButton.contentItem
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.baseline: parent.baseline
                    anchors.baselineOffset: 6

                    TextMetrics {
                        id: aFontMetrics
                        font: textColorButton.font
                        text: textColorButton.text
                    }
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
                font.family: localFont.name
                focusPolicy: Qt.TabFocus
                checkable: true
                checked: document.alignment == Qt.AlignLeft
                onClicked: document.alignment = Qt.AlignLeft

                contentItem: Image {
                    sourceSize.width: 20
                    sourceSize.height: 20
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
                }
            }

            ToolButton {
                id: alignCenterButton
                font.family: localFont.name
                focusPolicy: Qt.TabFocus
                checkable: true
                checked: document.alignment == Qt.AlignHCenter
                onClicked: document.alignment = Qt.AlignHCenter

                contentItem: Image {
                    sourceSize.width: 20
                    sourceSize.height: 20
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
                }
            }

            ToolButton {
                id: alignRightButton
                font.family: localFont.name
                focusPolicy: Qt.TabFocus
                checkable: true
                checked: document.alignment == Qt.AlignRight
                onClicked: document.alignment = Qt.AlignRight

                contentItem: Image {
                    sourceSize.width: 20
                    sourceSize.height: 20
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
                }
            }

            ToolButton {
                id: alignJustifyButton
                font.family: localFont.name
                focusPolicy: Qt.TabFocus
                checkable: true
                checked: document.alignment == Qt.AlignJustify
                onClicked: document.alignment = Qt.AlignJustify

                contentItem: Image {
                    sourceSize.width: 20
                    sourceSize.height: 20
//                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/select.png"
                }
            }
        }
    }
}