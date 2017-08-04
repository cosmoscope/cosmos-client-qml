import QtQuick 2.9
import Qt.labs.platform 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: window
    width: 1280
    height: 720
    visible: true
    title: qsTr("Side Panel")

    readonly property bool inPortrait: window.width < window.height

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

        DataListView { }
    }

    Flickable {
        id: flickable

        anchors.fill: parent
        anchors.topMargin: overlayHeader.height
        anchors.leftMargin: !inPortrait ? drawer.width : undefined

        topMargin: 0
        bottomMargin: 20
        contentHeight: column.height

        PlotTabArea {
            id: column
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }
}