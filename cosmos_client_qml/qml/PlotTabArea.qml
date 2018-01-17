import QtQuick 2.9
import Qt.labs.platform 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtCharts 2.2

ColumnLayout {
    spacing: 20

    anchors.fill: parent
    anchors.topMargin: overlayHeader.height
    anchors.leftMargin: !inPortrait ? drawer.width : undefined

    TabBar {
        anchors.fill: parent
        id: tabListBar

        Repeater {
            model: PlotListModel { }

            TabButton {
                text: model.name
            }
        }
    }

    StackLayout {
        id: stackLayout
        currentIndex: tabListBar.currentIndex

        Repeater {
            model: PlotListModel { }

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
                            var plotData = plotItems.get(i).plotData;

                            var series = chartView.createSeries(ChartView.SeriesTypeLine, "line"+ i, xAxis, yAxis);
        
                            series.pointsVisible = true;
                            series.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1);
                            // series.hovered.connect(function(point, state){ console.log(point); }); // connect onHovered signal to a function

                            for (var j = 0; j < plotData.count; j ++)
                            {
                                var x = plotData.get(j).x;
                                var y = Math.random();//plotData.get(j).y;
                                series.append(x, y);
                            }
                        }
                    }
                }
            }
        }
    }
}