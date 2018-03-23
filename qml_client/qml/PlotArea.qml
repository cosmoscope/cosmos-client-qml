import QtQuick 2.9
import Qt.labs.platform 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtCharts 2.2

StackLayout {
    currentIndex: tabListBar.currentIndex

    Repeater {
        id: plotItemRepeater
        model: plotTabModel

        Row {
            property var itemModel: model.tab.data_item_model

            Repeater {
                id: dataItemRepeater
                model: itemModel

                Item {
                    Connections {
                        target: model.item

                        onColorChanged: {
                            chartView.renderPlots();
                        }

                        onVisibilityChanged: {
                            chartView.renderPlots();
                        }
                    }
                }
            }

            ChartView {
                id: chartView
                anchors.fill: parent
                antialiasing: true
                legend.visible: false

                ValueAxis {
                    id: xAxis
                    min: 0
                    max: 10.0
                }

                ValueAxis {
                    id: yAxis
                    min: 0
                    max: 1
                }

                Component.onCompleted: {
                    renderPlots();
                }

                Connections {
                    target: dataItemRepeater

                    onItemAdded: {
                        chartView.renderPlots();
                     }

                    onItemRemoved: {
                        chartView.renderPlots();
                    }
                }

                function renderPlots() {
                    chartView.removeAllSeries();

                    var dataListCount = itemModel.rowCount()

                    for (var i = 0; i < dataListCount; i++)
                    {
                        var dataItem = itemModel.at(i);

                        if (!dataItem.visible) continue;

                        var series = chartView.createSeries(ChartView.SeriesTypeLine, dataItem.name, xAxis, yAxis);
                        series.pointsVisible = true;
                        series.color = dataItem.color;
                        series.hovered.connect(function(point, state){ console.log(point); }); // connect onHovered signal to a function

                        for (var j = 0 ; j < dataItem.data.length; j++)
                        {
                            series.append(dataItem.x(j), dataItem.y(j));
                        }
                    }
                }
            }

            PlotToolBar { }
        }
    }
}