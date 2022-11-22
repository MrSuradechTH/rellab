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
  late ZoomPanBehavior _zoomPanBehavior;
  late ChartSeriesController _chartSeriesController;
  late ChartSeriesController _chartSeriesControllers;
  late final int stack;
  // late final int TempMax = 168,TempMin = -80,HumidityMax = 85,HumidityMin = 0;

  @override
  void initState() {
    _data = getChartData();
    _trackballBehavior = TrackballBehavior(
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
        format: "point.y",
      ),
    );
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: false, //enable for zoom in out
      zoomMode: ZoomMode.xy,
      maximumZoomLevel: 0.5,
    );
    Timer.periodic(const Duration(seconds: 1), (timer) { 
        updateData();
    });
    // Timer.periodic(const Duration(milliseconds: 100), (timer) => update());
    // timer = Timer.periodic(Duration(seconds: 15), (Timer t) => checkForNewSharedLists());
    super.initState();
  }

  late double xmax = 60;
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: 500,
          height: 250,
          child: SfCartesianChart(
            title: ChartTitle(text: 'TEMPCYCLE#01'),
            zoomPanBehavior: _zoomPanBehavior,
            legend: Legend(
              isVisible: true,
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
                name: 'Temp',
                xValueMapper: (SalesData sales, _) => sales.time,
                yValueMapper: (SalesData sales, _) => sales.temp,
                // dataLabelSettings: DataLabelSettings(isVisible: true), //enable for show value on line
                // enableTooltip: true, //enable for text box on trackball
              ),
              LineSeries<SalesData, double>(
                onRendererCreated: (ChartSeriesController controller) {
                  _chartSeriesControllers = controller;
                },
                color: Colors.blue,
                dataSource: _data,
                name: 'Humidity',
                xValueMapper: (SalesData sales, _) => sales.time,
                yValueMapper: (SalesData sales, _) => sales.humidity,
                // pointColorMapper:(SalesData data, _) => data.color,
                // dataLabelSettings: DataLabelSettings(isVisible: true), //enable for show value on line
                // enableTooltip: true, //enable for text box on trackball
              ),
            ],
            primaryXAxis: NumericAxis(
              // minimum: 0,
              // // maximum: xmax+=1,
              // maximum: 100,
              interval: 1,
              title: AxisTitle(text: "Time(S)"),
            ),
            primaryYAxis: NumericAxis(
              minimum: -80,
              maximum: 180,
              interval: 1,
              title: AxisTitle(text: "Value"),
              // labelFormat: '{value}M', //add befor and after text value
              // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0) //$format befor text value
            ),
          ),
        ),
      ),
    );
  }
  late int timenow = xmax.toInt();
  List<SalesData> getChartData() {
    
    final List<SalesData> chartData = [];
    for (var i = 0;i < timenow;i++) {
      int randoma = -80 + Random().nextInt(160 - -80);
      int randomb = -80 + Random().nextInt(160 - -80);
      // chartData.add(SalesData(i.toDouble(), randoma.toDouble(), randomb.toDouble(), Colors.green));
      chartData.add(SalesData(i.toDouble(), randoma.toDouble(), randomb.toDouble()));
    }
    // chartData.add(SalesData(5, 5, 5, Colors.red));
    return chartData;
  }

  
  void updateData() {
    xmax+=1;
    // if (kDebugMode) {
    //   print("update");
    //   print(timenow.toString() + xmax.toString());
    //   }
      // final List<SalesData> chartData = [];
    int randoma = -80 + Random().nextInt(160 - -80);
    int randomb = -80 + Random().nextInt(160 - -80);
    // chartData.add(SalesData(i.toDouble(), randoma.toDouble(), randomb.toDouble(), Colors.green));
    _data.add(SalesData((timenow+=1).toDouble(), randoma.toDouble(), randomb.toDouble()));
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
  // SalesData(this.time, this.temp, this.humidity, this.color);
  final double time;
  final double temp;
  final double humidity;
  // final Color color;
}