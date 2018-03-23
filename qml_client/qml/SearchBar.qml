import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.platform 1.0

FocusScope {
    id: focusScope
    width: parent.width
    height: 18

    //                    BorderImage {
    //                        source: "images/lineedit-bg.png"
    //                        width: parent.width; height: parent.height
    //                        border { left: 4; top: 4; right: 4; bottom: 4 }
    //                    }
    //
    //                    BorderImage {
    //                        source: "images/lineedit-bg-focus.png"
    //                        width: parent.width; height: parent.height
    //                        border { left: 4; top: 4; right: 4; bottom: 4 }
    //                        visible: parent.activeFocus ? true : false
    //                    }

    Text {
        id: typeSomething
        anchors.fill: parent
        anchors.leftMargin: 4
        verticalAlignment: Text.AlignVCenter
        text: "Type something..."
        color: "gray"
        font.italic: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            focusScope.focus = true
            textInput.openSoftwareInputPanel
        }
    }

    TextInput {
        id: textInput
        anchors {
            left: parent.left
            leftMargin: 4
            right: clear.left
            rightMargin: 4
            verticalCenter: parent.verticalCenter
        }
        focus: true
        selectByMouse: true
    }

    Text {
        id: clear
        width: 18
        height: 18

        anchors {
            right: parent.right
        }

        text: qsTr("×")
        font.pointSize: 20
        opacity: 0

        MouseArea {
            anchors.fill: parent
            onClicked: {
                textInput.text = ''
                focusScope.focus = true
                textInput.openSoftwareInputPanel
            }
        }
    }

    states: State {
        name: "hasText"
        when: textInput.text != ''
        PropertyChanges {
            target: typeSomething
            opacity: 0
        }
        PropertyChanges {
            target: clear
            opacity: 1
        }
    }

    transitions: [
        Transition {
            from: ""
            to: "hasText"
            NumberAnimation {
                exclude: typeSomething
                properties: "opacity"
            }
        },
        Transition {
            from: "hasText"
            to: ""
            NumberAnimation {
                properties: "opacity"
            }
        }
    ]
}