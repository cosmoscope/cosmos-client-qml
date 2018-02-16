import QtQuick 2.9
import Qt.labs.platform 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtCharts 2.2

ApplicationWindow {
    id: window
    width: 1280
    height: 720
    visible: true
    title: qsTr("Cosmoscope")

    readonly property bool inPortrait: window.width < window.height

    property var model: plotTabModel

    MainMenuBar {
        id: mainMenuBar
    }

    MainToolBar {
        id: overlayHeader
     }

    Drawer {
        id: drawer

        y: overlayHeader.height
        width: 300
        height: window.height - overlayHeader.height

        modal: inPortrait
        interactive: inPortrait
        position: inPortrait ? 0 : 1
        visible: !inPortrait

        background: Rectangle {
            Rectangle {
                x: parent.width - 1
                width: 1
                height: parent.height
                color: "light grey"
            }
        }

        DataListView {
            id: dataListView
            model: window.model.tab.data_item_model // != undefined ? window.model.get(plotTabs.currentIndex).plotItems : null

            Component.onCompleted: {
                console.log(window.model.data(0, 0));
                console.log(window.model[plotTabs.currentIndex].tab);
                console.log(window.model[plotTabs.currentIndex].tab.data_item_model);
            }
        }
    }

    ColumnLayout {
        spacing: 20
        anchors.fill: parent
        anchors.topMargin: overlayHeader.height
        anchors.leftMargin: !inPortrait ? drawer.width : undefined

        PlotTabs { 
            id: plotTabs
            model: window.model
        }

        PlotArea {
            id: plotArea
            currentIndex: plotTabs.currentIndex
            model: window.model
        }
    }
}