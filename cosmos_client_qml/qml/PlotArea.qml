import QtQuick 2.9
import Qt.labs.platform 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtCharts 2.2

StackLayout {
    currentIndex: tabListBar.currentIndex

    property var model

    Repeater {
        model: parent.model

        Item {
            ChartView {
                id: chartView
                anchors.fill: parent
                antialiasing: true
                legend.visible: false
                axes: [
                    ValueAxis{
                        id: xAxis
                        min: 1.0
                        max: 10.0
                    },
                    ValueAxis{
                        id: yAxis
                        min: 0
                        max: 1
                    }
                ]

                Component.onCompleted: {
                    for (var i = 0; i < plotItems.count; i++)
                    {
                        var plotItem = plotItems.get(i);
                        var plotData = plotItem.plotData;

                        console.log(plotData);

                        var series = chartView.createSeries(ChartView.SeriesTypeLine, "line"+ i, xAxis, yAxis);
    
                        series.pointsVisible = true;
                        series.color = plotItem.style.get(0).color;
                        series.opacity = plotItem.style.get(0).opacity;
                        // series.hovered.connect(function(point, state){ console.log(point); }); // connect onHovered signal to a function

                        for (var j = 0; j < 10; j++)
                        {
                            var x = j + 1; // plotData.get(j).x;
                            var y = Math.random(); // plotData.get(j).y;
                            series.append(x, y);
                        }
                    }
                }
            }
        }
    }
}