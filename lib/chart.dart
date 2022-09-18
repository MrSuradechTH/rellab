import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const CHART());
}

class CHART extends StatelessWidget {
  const CHART({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LINE CHART',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const CHARTS(title: 'LINE CHART'),
    );
  }
}

class CHARTS extends StatefulWidget {
  const CHARTS({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CHARTS> createState() => _CHARTSState();
}

class _CHARTSState extends State<CHARTS> {
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
      enablePinching: false, //enable for zoom in out
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
              // dataLabelSettings: DataLabelSettings(isVisible: true), //enable for show value on line
              // enableTooltip: true, //enable for text box on trackball
            ),
          ],
          primaryXAxis: NumericAxis(
            minimum: 0,
            maximum: 100,
            interval: 1,
            edgeLabelPlacement: EdgeLabelPlacement.shift,
          ),
          primaryYAxis: NumericAxis(
            minimum: -80,
            maximum: 180,
            interval: 1,
            // labelFormat: '{value}M', //add befor and after text value
            // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0) //$format befor text value
          ),
        ),
      ),
    );
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