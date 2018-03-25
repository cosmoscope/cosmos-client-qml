import QtQuick 2.9
import Qt.labs.platform 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

TabBar {
    property var itemModel

    Repeater {
        id: plotTabsRepeater
        model: plotTabModel

        TabButton {
            text: model.tab.name

            property var itemModel: model.tab.data_item_model

            ToolButton {
                id: closeButton
                height: parent.height
                width: parent.height
                anchors.right: parent.right

                contentItem: Text {
                    text: qsTr("×")
                    font.pointSize: 20

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                background: Rectangle {
                    height: parent.height
                    color: closeButton.down ? "#d6d6d6" : "transparent"
                }

                onClicked: deletePlot(index)
            }
        }
    }

    onCurrentIndexChanged: {
        itemModel = plotTabsRepeater.itemAt(currentIndex).itemModel;
    }

    function deletePlot(index) {
        // Select the next tab
        incrementCurrentIndex();
        plotTabsRepeater.model.removeRow(index);
    }
}