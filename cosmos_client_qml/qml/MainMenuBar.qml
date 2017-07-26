import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.platform 1.0

MenuBar {
    id: menuBar

    Menu {
        id: fileMenu
        title: qsTr("File")

        MenuItem {
            text: qsTr("&Open")
//                onTriggered: openDialog.open()
        }
        MenuItem {
            text: qsTr("&Save As...")
//                onTriggered: saveDialog.open()
        }
        MenuItem {
            text: qsTr("&Quit")
//                onTriggered: Qt.quit()
        }
    }

    Menu {
        id: editMenu
        title: qsTr("Edit")
        // ...
    }

    Menu {
        id: viewMenu
        title: qsTr("View")
        // ...
    }

    Menu {
        id: helpMenu
        title: qsTr("&Help")
        // ...
    }
}