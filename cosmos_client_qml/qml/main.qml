import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.platform 1.0

ApplicationWindow {
    visible: true
    width: 1280
    height: 720
    title: qsTr("Hello World")

    MainMenuBar { }

//    header: MainToolBar { }

    Row {
        id: contentRow

        RowItem{
            Rectangle {
                width: 180; height: 200

                Component {
                    id: contactDelegate
                    Item {
                        width: 180; height: 40
                        Column {
                            Text { text: '<b>Name:</b> ' + name }
                            Text { text: '<b>Number:</b> ' + number }
                        }
                    }
                }

                ListView {
                    anchors.fill: parent
                    model: DataListModel {}
                    delegate: contactDelegate
                    highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                    focus: true
                }
            }
        }

        RowItem {
            SwipeView {
                id: swipeView
                anchors.fill: parent
                currentIndex: tabBar.currentIndex

                Page {
                    Label {
                        text: qsTr("First page")
                        anchors.centerIn: parent
                    }
                }

                Page {
                    Label {
                        text: qsTr("Second page")
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("First")
        }
        TabButton {
            text: qsTr("Second")
        }
    }
}