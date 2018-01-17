import QtQuick 2.9
import QtCharts 2.2

ListModel {
    id: plotListModel

    ListElement {
        name: "Plot Set 1"

        // A ListElement can't contain child elements, but it can contain
        // a list of elements. A list of ListElements can be used as a model
        // just like any other model type.
        plotItems: [
            ListElement {
                name: "Plot 1"
                plotData: [
                    ListElement { x: 0; y: 12 },
                    ListElement { x: 1; y: 12 },
                    ListElement { x: 2; y: 12 },
                    ListElement { x: 3; y: 12 }
                ]
            },
            ListElement {
                name: "Plot 2"
                plotData: [
                    ListElement { x: 0; y: 13 },
                    ListElement { x: 1; y: 13 },
                    ListElement { x: 2; y: 13 },
                    ListElement { x: 3; y: 13 }
                ]
            }
        ]
    }

    ListElement {
        name: "Plot Set 1"

        // A ListElement can't contain child elements, but it can contain
        // a list of elements. A list of ListElements can be used as a model
        // just like any other model type.
        plotItems: [
            ListElement {
                name: "Plot 1"
                plotData: [
                    ListElement { x: 0; y: 12 },
                    ListElement { x: 1; y: 12 },
                    ListElement { x: 2; y: 12 },
                    ListElement { x: 3; y: 12 }
                ]
            }
        ]
    }
}