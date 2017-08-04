import QtQuick 2.9
import Qt.labs.platform 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Column {
    spacing: 20
    anchors.margins: 0
    anchors.left: parent.left
    anchors.right: parent.right

    TabBar {
        anchors.fill: parent
        id: bar

        TabButton {
            text: qsTr("Home")

            Button {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                height: 20; width: 20
                text: qsTr("x")
            }
        }
        TabButton {
            text: qsTr("Discover")
        }
        TabButton {
            text: qsTr("Activity")
        }
    }

    StackLayout {
        width: parent.width
        currentIndex: bar.currentIndex

        Item {
            id: homeTab
            Rectangle {
                anchors.fill: parent
                color: "red"
            }
        }
        Item {
            id: discoverTab
            Rectangle {
                anchors.fill: parent
                color: "green"
            }
        }
        Item {
            id: activityTab

            Rectangle {
                anchors.fill: parent
                color: "blue"
            }
        }
    }
}