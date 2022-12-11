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
  double temp = 0.0,humid = 0.0;

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
    _trackballBehaviors = TrackballBehavior(
      tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
        format: "point.y %",
      ),
    );
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      getdata(mode[0]);
      updateData();
    });
    super.initState();
  }

  late double xmax = 60;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("MACHINE STATUS"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(sharedata[1],style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                Container(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  width: 500,
                  height: 250,
                  child: SfCartesianChart(
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
                      interval: 100,
                      title: AxisTitle(text: "Time(S)",alignment: ChartAlignment.center),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: -80,
                      maximum: 180,
                      interval: 10,
                      title: AxisTitle(text: "Temperature(°C)"),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  width: 500,
                  height: 250,
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'HUMIDITY'),
                    legend: Legend(
                      isVisible: false,
                      position: LegendPosition.bottom,
                      alignment: ChartAlignment.near,
                    ),
                    trackballBehavior: _trackballBehaviors,
                    series: <ChartSeries>[
                      LineSeries<SalesData, double>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesControllers = controller;
                        },
                        color: Colors.blue,
                        dataSource: _data,
                        xValueMapper: (SalesData sales, _) => sales.time,
                        yValueMapper: (SalesData sales, _) => sales.humidity,
                      ),
                    ],
                    primaryXAxis: NumericAxis(
                      interval: 100,
                      title: AxisTitle(text: "Time(S)"),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: 100,
                      interval: 5,
                      title: AxisTitle(text: "Humidity(%)"),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                ),
                Text(
                  sprintf("Temp %5.2f °C",[temp]),
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  sprintf("Hum   %5.2f %",[humid]),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [];
    for (var i = 0;i < xmax;i++) {
      // int randoma = -80 + Random().nextInt(160 - -80);
      // int randomb = 0 + Random().nextInt(100 - 0);
      // int a = datain['temp'];
      chartData.add(SalesData(i.toDouble(), double.parse('0'), double.parse('0')));
    }
    return chartData;
  }
  
  void updateData() {
    xmax+=1;
    // int randoma = -80 + Random().nextInt(160 - -80);
    // int randomb = 0 + Random().nextInt(100 - 0);
    _data.add(SalesData(xmax.toDouble(), double.parse(datain['temp']), double.parse(datain['humid'])));
    _data.removeAt(0);

    _chartSeriesController.updateDataSource(
      addedDataIndex: _data.length -1,
      removedDataIndex: 0,
    );

    _chartSeriesControllers.updateDataSource(
      addedDataIndex: _data.length -1,
      removedDataIndex: 0,
    );

    setState(() {
      // temp = randoma.toDouble();
      // humid = randomb.toDouble();

      temp = double.parse(datain['temp']);
      humid = double.parse(datain['humid']);;
    });
  }
}

class SalesData {
  SalesData(this.time, this.temp, this.humidity);
  final double time;
  final double temp;
  final double humidity;
}