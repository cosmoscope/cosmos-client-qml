import QtQuick 2.9
import Qt.labs.platform 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

TabBar {
    id: plotTabs
    anchors.fill: parent

    property var model

    Repeater {
        id: plotTabsRepeater
        model: plotTabs.model

        TabButton {
            text: model.name
            RowLayout {
                anchors.fill: parent
                ToolButton {
                    anchors.right: parent.right
                    text: qsTr("×")
                    font.pointSize: 20
                    onClicked: deletePlot(index)
                }
            }
        }
    }

    function deletePlot(index) {
        // Select the next tab
        incrementCurrentIndex();
        model.remove(index, 1);
    }
}