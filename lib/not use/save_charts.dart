import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';

void main() {
  runApp(const CHART());
}

class CHART extends StatefulWidget {
  const CHART({Key? key}) : super(key: key);

  @override
  State<CHART> createState() => _CHARTState();
}

class _CHARTState extends State<CHART> {
  late List<SalesData> _data;
  late TrackballBehavior _trackballBehavior;
  late ChartSeriesController _chartSeriesController;
  late ChartSeriesController _chartSeriesControllers;
  late final int stack;

  @override
  void initState() {
    _data = getChartData();
    _trackballBehavior = TrackballBehavior(
      tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
        format: "point.y °C",
      ),
    );
    Timer.periodic(const Duration(seconds: 1), (timer) { 
        updateData();
    });
    super.initState();
  }

  late double xmax = 100;
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SfCartesianChart(
              title: ChartTitle(text: 'TEMPERATURE'),
              legend: Legend(
                isVisible: false,
                position: LegendPosition.bottom,
                alignment: ChartAlignment.near,
              ),
              trackballBehavior: _trackballBehavior,
              series: <ChartSeries>[
                LineSeries<SalesData, double>(
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesController = controller;
                  },
                  color: Colors.red,
                  dataSource: _data,
                  xValueMapper: (SalesData sales, _) => sales.time,
                  yValueMapper: (SalesData sales, _) => sales.temp,
                ),
              ],
              primaryXAxis: NumericAxis(
                interval: 1,
                title: AxisTitle(text: "Time(S)"),
              ),
              primaryYAxis: NumericAxis(
                minimum: -80,
                maximum: 180,
                interval: 1,
                title: AxisTitle(text: "Temperature(°C)"),
              ),
            ),
            SfCartesianChart(
              title: ChartTitle(text: 'HUMIDITY'),
              legend: Legend(
                isVisible: false,
                position: LegendPosition.bottom,
                alignment: ChartAlignment.near,
              ),
              trackballBehavior: _trackballBehavior,
              series: <ChartSeries>[
                LineSeries<SalesData, double>(
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesControllers = controller;
                  },
                  color: Colors.blue,
                  dataSource: _data,
                  xValueMapper: (SalesData sales, _) => sales.time,
                  yValueMapper: (SalesData sales, _) => sales.temp,
                ),
              ],
              primaryXAxis: NumericAxis(
                interval: 1,
                title: AxisTitle(text: "Time(S)"),
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 100,
                interval: 1,
                title: AxisTitle(text: "Humidity(%)"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<SalesData> getChartData() {
    
    final List<SalesData> chartData = [];
    for (var i = 0;i < xmax;i++) {
      int randoma = -80 + Random().nextInt(160 - -80);
      int randomb = -80 + Random().nextInt(160 - -80);
      chartData.add(SalesData(i.toDouble(), randoma.toDouble(), randomb.toDouble()));
    }
    return chartData;
  }

  
  void updateData() {
    xmax+=1;
    int randoma = -80 + Random().nextInt(160 - -80);
    int randomb = -80 + Random().nextInt(160 - -80);
    _data.add(SalesData((xmax+=1).toDouble(), randoma.toDouble(), randomb.toDouble()));
    _data.removeAt(0);

    _chartSeriesController.updateDataSource(
      addedDataIndex: _data.length -1,
      removedDataIndex: 0,
    );

    _chartSeriesControllers.updateDataSource(
      addedDataIndex: _data.length -1,
      removedDataIndex: 0,
    );
    // }
  }
}

class SalesData {
  SalesData(this.time, this.temp, this.humidity);
  final double time;
  final double temp;
  final double humidity;
}