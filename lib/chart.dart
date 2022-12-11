import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rellab/share_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'package:sprintf/sprintf.dart';

class CHART extends StatefulWidget {
  const CHART({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<CHART> createState() => _CHARTState();
}

class _CHARTState extends State<CHART> {
  late final List<SalesData> _data;
  late TrackballBehavior _trackballBehavior;
  late TrackballBehavior _trackballBehaviors;
  late ChartSeriesController _chartSeriesController;
  late ChartSeriesController _chartSeriesControllers;
  late final int stack;
  double temp = 0.0, humid = 0.0;

  @override
  void initState() {
    chart_start = false;
    first_time = true;
    _data = getChartData();
    _trackballBehavior = TrackballBehavior(
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
        format: "point.y °C",
      ),
    );
    _trackballBehaviors = TrackballBehavior(
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
        format: "point.y %RH",
      ),
    );
    Timer.periodic(const Duration(milliseconds: updatedelay), (timer) async {
      // print("loogsize = " + logsize.toString() + ":xmax = " + xmax.toString());
      if (chart_start == true) {
        print(_data.length);
        getdata(mode[0]);
        updateData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("MACHINE STATUS"),
          automaticallyImplyLeading: true,
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  sharedata[1],
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  width: chartw,
                  height: charth,
                  child: SfCartesianChart(
                    title: ChartTitle(
                        text: sprintf("Temp %5.2f °C", [temp]),
                        textStyle: const TextStyle(fontSize: 20)),
                    legend: Legend(
                      isVisible: false,
                      position: LegendPosition.bottom,
                      alignment: ChartAlignment.near,
                    ),
                    trackballBehavior: _trackballBehavior,
                    series: <ChartSeries>[
                      LineSeries<SalesData, String>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController = controller;
                        },
                        color: Colors.red,
                        dataSource: _data,
                        xValueMapper: (SalesData sales, _) => sales.time,
                        yValueMapper: (SalesData sales, _) => sales.temp,
                      ),
                    ],
                    primaryXAxis: CategoryAxis(
                      //String
                      interval: 60,
                      labelRotation: 90,
                      tickPosition: TickPosition.inside,
                      title: AxisTitle(
                          text: "Time(S)", alignment: ChartAlignment.center),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      //Number
                      minimum: -80,
                      maximum: 180,
                      interval: 10,
                      tickPosition: TickPosition.inside,
                      title: AxisTitle(text: "Temperature(°C)"),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  width: chartw,
                  height: charth,
                  child: SfCartesianChart(
                    title: ChartTitle(
                        text: sprintf("Hum   %5.2f %%RH", [humid]),
                        textStyle: const TextStyle(fontSize: 20)),
                    legend: Legend(
                      isVisible: false,
                      position: LegendPosition.bottom,
                      alignment: ChartAlignment.near,
                    ),
                    trackballBehavior: _trackballBehaviors,
                    series: <ChartSeries>[
                      LineSeries<SalesData, String>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesControllers = controller;
                        },
                        color: Colors.blue,
                        dataSource: _data,
                        xValueMapper: (SalesData sales, _) => sales.time,
                        // sales.time - xmax%10 - 1
                        yValueMapper: (SalesData sales, _) => sales.humidity,
                      ),
                    ],
                    primaryXAxis: CategoryAxis(
                      //String
                      interval: 60,
                      labelRotation: 90,
                      // isVisible: false, //hide
                      tickPosition: TickPosition.inside,
                      title: AxisTitle(text: "Time(S)"),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      //Number
                      minimum: 0,
                      maximum: 100,
                      interval: 5,
                      tickPosition: TickPosition.inside,
                      title: AxisTitle(text: "Humidity(%)"),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<SalesData> getChartData() {
    setState(() {
      getdata(mode[1]);
    });
    final List<SalesData> chartData = [];
    // chartData.length = 0;
    chartData.add(SalesData('START', double.parse('0'), double.parse('0')));
    Timer(const Duration(seconds: 5), () {
      for (var i = 0; i < xmax - 1; i++) {
        // int randoma = -80 + Random().nextInt(160 - -80);
        // int randomb = 0 + Random().nextInt(100 - 0);
        // String a = "0.0";

        if (i >= xmax - logsize + 1) {
          chartData.add(SalesData(
              logarrray[(((logsize - 1) - (logsize - (xmax - i))) + 1).toInt()]
                  ['time'],
              double.parse(logarrray[
                      (((logsize - 1) - (logsize - (xmax - i))) + 1).toInt()]
                  ['temp']),
              double.parse(logarrray[
                      (((logsize - 1) - (logsize - (xmax - i))) + 1).toInt()]
                  ['humid'])));
        } else {
          // chartData.add(SalesData(
          //     logarrray[logsize - 1]['time'],
          //     double.parse(logarrray[logsize - 1]['temp']),
          //     double.parse(
          //         logarrray[logsize - 1]['humid'])));
          chartData.add(SalesData('START', double.parse('0'), double.parse('0')));
        }
      }
      chart_start = true;
    });
    return chartData;
  }

  void updateData() {
    xmax += 1;
    // int randoma = -80 + Random().nextInt(160 - -80);
    // int randomb = 0 + Random().nextInt(100 - 0);
    if (first_time == true) {
      _data.add(SalesData(
          logarrray[0]['time'],
          double.parse(logarrray[0]['temp']),
          double.parse(logarrray[0]['humid'])));
      first_time = false;
    } else {
      _data.add(SalesData(
          datain['time'] ?? "",
          double.parse(datain['temp'] ?? "0"),
          double.parse(datain['humid'] ?? "0")));
    }
    _data.removeAt(0);

    _chartSeriesController.updateDataSource(
      addedDataIndex: _data.length - 1,
      removedDataIndex: 0,
    );

    _chartSeriesControllers.updateDataSource(
      addedDataIndex: _data.length - 1,
      removedDataIndex: 0,
    );

    if (!mounted) return;
    setState(() {
      // temp = randoma.toDouble();
      // humid = randomb.toDouble();

      temp = double.parse(datain['temp'] ?? "0");
      humid = double.parse(datain['humid'] ?? "0");
    });
  }
}

class SalesData {
  final String time;
  final double temp;
  final double humidity;
  SalesData(this.time, this.temp, this.humidity);
}
