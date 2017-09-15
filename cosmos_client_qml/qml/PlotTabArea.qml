import QtQuick 2.9
import Qt.labs.platform 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
//import QtCharts 2.2

Column {
    spacing: 20
    anchors.margins: 0
    anchors.left: parent.left
    anchors.right: parent.right

    TabBar {
        anchors.fill: parent
        id: bar

//        Repeater {
//            model: plot_list
//
//            TabButton {
//                text: name
//            }
//        }
    }

    StackLayout {
        width: parent.width
        currentIndex: bar.currentIndex

        Item {
            id: homeTab
            Rectangle {
                anchors.fill: parent
                color: "red"

//                ChartView {
//                    title: "Line"
//                    anchors.fill: parent
//                    antialiasing: true
//
//                    LineSeries {
//                        name: "LineSeries"
//                        XYPoint { x: 0; y: 0 }
//                        XYPoint { x: 1.1; y: 2.1 }
//                        XYPoint { x: 1.9; y: 3.3 }
//                        XYPoint { x: 2.1; y: 2.1 }
//                        XYPoint { x: 2.9; y: 4.9 }
//                        XYPoint { x: 3.4; y: 3.0 }
//                        XYPoint { x: 4.1; y: 3.3 }
//                    }
//                }
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