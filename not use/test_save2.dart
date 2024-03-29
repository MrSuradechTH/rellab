import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LINE CHART',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'LINE CHART'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<SalesData> _chartData;
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _trackballBehavior = TrackballBehavior(
      enable: true, 
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
        format: "point.y °C",
      ),
      );
      _zoomPanBehavior = ZoomPanBehavior(
        enablePinching: true,
       zoomMode: ZoomMode.xy,
       maximumZoomLevel: 0.5,
     );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfCartesianChart(
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
            name: 'Temp',
            color: Colors.red,
            dataSource: _chartData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            // dataLabelSettings: DataLabelSettings(isVisible: true),
            // enableTooltip: true
        ),
      ],
      primaryXAxis: NumericAxis(
        // name: "value",
        minimum: 0,
        maximum: 100,
        interval: 1,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
        // title: 'fr',
        minimum: -80,
        maximum: 180,
        interval: 1,
          // labelFormat: '{value}M',
          // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)
          ),
    )));
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(0, 0),
      SalesData(1, 12),
      SalesData(4, 24),
      SalesData(5, 18),
      SalesData(10, 3)
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}