import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rellab/share_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'package:sprintf/sprintf.dart';

//jsonget
import 'dart:convert';
import 'package:http/http.dart' as http;

class CHART extends StatefulWidget {
  const CHART({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<CHART> createState() => _CHARTState();
}

//jsonget
List<dynamic> mode = ["monitor", "log"];
Map<dynamic, dynamic> datain = {};
const int updatedelay = 990;
List<dynamic> logarrray = [];
int logsize = 0;
bool chartstart = false;
bool firsttime = true;

class _CHARTState extends State<CHART> {
  late final List<SalesData> _data;
  late TrackballBehavior _trackballBehavior;
  late TrackballBehavior _trackballBehaviors;
  late ChartSeriesController _chartSeriesController;
  late ChartSeriesController _chartSeriesControllers;
  late ZoomPanBehavior _zoomPanBehavior;
  late final int stack;
  double temp = 0.0, humid = 0.0;
  String timenow = "", lasttime = "";
  bool update = false,scroll = true,humidmachine = sharedata[1].contains("TEMPHUMID") ? true : false;

  @override
  void initState() {
    chartstart = false;
    firsttime = true;
    _data = getChartData();
    _trackballBehavior = TrackballBehavior(
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
        textStyle: TextStyle(
          fontFamily: "Righteous-Regular",
          fontSize: 15
        ),
        format: "point.y °C",
      ),
    );
    _trackballBehaviors = TrackballBehavior(
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
        textStyle: TextStyle(
          fontFamily: "Righteous-Regular",
          fontSize: 15
        ),
        format: "point.y %RH",
      ),
    );
    _zoomPanBehavior = ZoomPanBehavior(
      zoomMode: ZoomMode.x,
      enableMouseWheelZooming: true,
    );
    Timer.periodic(const Duration(milliseconds: updatedelay), (timer) async {
      // if (kDebugMode) {
      //   print("loogsize = $logsize :xmax = $xmax");
      // }
      if (chartstart == true) {
        // print(_data.length);
        getdata(mode[0]);
        timenow = datain['time'] ?? "";
        if (timenow != lasttime) {
          lasttime = timenow;
          updateData();
        }
        // if (kDebugMode) {
        //   print("loop");
        // }
      }
      // if (kDebugMode) {
      //   print("endloop");
      // }
    });
    super.initState();
  }

  // Widget name(int i) {

  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "MACHINE STATUS",
            style: font[0],
          ),
          automaticallyImplyLeading: true,
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
          child: SingleChildScrollView(
            physics: RawKeyboard.instance.keysPressed.contains(LogicalKeyboardKey.controlLeft) ? const NeverScrollableScrollPhysics() : null,
            child: Column(
              children: [
                Text(sharedata[1],style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                Container(height: 10,),
                Container(
                  padding: const EdgeInsets.all(0),
                  width: chartw,
                  height: charth,
                  child: SfCartesianChart(
                    zoomPanBehavior: RawKeyboard.instance.keysPressed.contains(LogicalKeyboardKey.controlLeft) ? _zoomPanBehavior : null,
                    title: ChartTitle(
                        text: sprintf("Temp %5.2f °C", [temp]),
                        textStyle: const TextStyle(
                          fontFamily: "Righteous-Regular",
                          fontSize: 25
                        ),
                    ),
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
                      interval: xmax / 25,
                      labelRotation: 90,
                      // isVisible: false, //hide
                      tickPosition: TickPosition.inside,
                      title: AxisTitle(
                        text: "Time(S)",
                        textStyle:const TextStyle(
                          fontFamily: "Righteous-Regular",
                          fontSize: 20
                        ),
                        alignment: ChartAlignment.center
                      ),
                      labelStyle: const TextStyle(
                        fontFamily: "Righteous-Regular",
                        fontSize: 10
                      ),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      //Number
                      minimum: -80,
                      maximum: 180,
                      interval: 10,
                      tickPosition: TickPosition.inside,
                      title: AxisTitle(
                        text: "Temperature(°C)",
                        textStyle: const TextStyle(
                          fontFamily: "Righteous-Regular",
                          fontSize: 20
                        ),
                      ),
                      labelStyle: const TextStyle(
                        fontFamily: "Righteous-Regular",
                        fontSize: 10
                      ),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                  ),
                ),
                if (humidmachine) Container(
                  padding: const EdgeInsets.all(0),
                  width: chartw,
                  height: charth,
                  child: SfCartesianChart(
                    zoomPanBehavior: RawKeyboard.instance.keysPressed.contains(LogicalKeyboardKey.controlLeft) ? _zoomPanBehavior : null,
                    title: ChartTitle(
                      text: sprintf("Hum   %5.2f %%RH", [humid]),
                      textStyle: const TextStyle(
                        fontFamily: "Righteous-Regular",
                        fontSize: 25
                      ),
                    ),
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
                        yValueMapper: (SalesData sales, _) => sales.humidity,
                      ),
                    ],
                    primaryXAxis: CategoryAxis(
                      //String
                      interval: xmax / 25,
                      labelRotation: 90,
                      // isVisible: false, //hide time
                      tickPosition: TickPosition.inside,
                      title: AxisTitle(
                        text: "Time(S)",
                        textStyle:const TextStyle(
                          fontFamily: "Righteous-Regular",
                          fontSize: 20
                        ),
                        alignment: ChartAlignment.center
                      ),
                      labelStyle: const TextStyle(
                        fontFamily: "Righteous-Regular",
                        fontSize: 10
                      ),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      //Number
                      minimum: 0,
                      maximum: 100,
                      interval: 5,
                      tickPosition: TickPosition.inside,
                      title: AxisTitle(
                        text: "Humidity(%)",
                        textStyle: const TextStyle(
                          fontFamily: "Righteous-Regular",
                          fontSize: 20
                        ),
                      ),
                      labelStyle: const TextStyle(
                        fontFamily: "Righteous-Regular",
                        fontSize: 10
                      ),
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
      for (var i = 0; i < xmax; i++) {
        // int randoma = -80 + Random().nextInt(160 - -80);
        // int randomb = 0 + Random().nextInt(100 - 0);
        // String a = "0.0";

        if (i >= xmax - logsize + 1) {
          chartData.add(
            SalesData(logarrray[(((logsize - 1) - (logsize - (xmax - i))) + 1).toInt()]['time'],
            double.parse(logarrray[(((logsize - 1) - (logsize - (xmax - i))) + 1).toInt()]['temp']),
            double.parse(logarrray[(((logsize - 1) - (logsize - (xmax - i))) + 1).toInt()]['humid']))
          );
        } else {
          // chartData.add(SalesData(
          //     logarrray[logsize - 1]['time'],
          //     double.parse(logarrray[logsize - 1]['temp']),
          //     double.parse(
          //         logarrray[logsize - 1]['humid'])));
          chartData.add(SalesData('START', double.parse('0'), double.parse('0')));
        }
      }
      chartstart = true;
    });
    return chartData;
  }

  void updateData() {
    xmax += 1;
    // int randoma = -80 + Random().nextInt(160 - -80);
    // int randomb = 0 + Random().nextInt(100 - 0);
    if (firsttime == true) {
      _data.add(SalesData(
        logarrray[0]['time'],
        double.parse(logarrray[0]['temp']),
        double.parse(logarrray[0]['humid'])));
      firsttime = false;
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

    if (humidmachine) {
      _chartSeriesControllers.updateDataSource(
        addedDataIndex: _data.length - 1,
        removedDataIndex: 0,
      );
    }

    if (!mounted) {
      http.Client().close();
      return;
    }
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

// List<List<dynamic>> dataneed = [[],[],[]]; //array
Future getdata(String m) async {
  if (m == mode[0]) {
    // final txt = await http.Client().get(Uri.parse(server));
    Map<String, String> body = {
      'mode': mode[0],
      'name': sharedata[1],
    };

    // int timeout = 5;
    // try {
    //   http.Response response = await http.get('someUrl').
    //       timeout(Duration(seconds: timeout));
    //   if (response.statusCode == 200) {
    //     // do something
    //   } else {
    //     // handle it
    //   }
    // }  on Error catch (e) {
    //   print('General Error: $e');
    // }

    // http.Client().close();
    final txt = await http.post(Uri.parse(server), body: body).timeout(const Duration(seconds: updatedelay));

    if (txt.statusCode == 200) {
      // print(jsonDecode(txt.body));
      datain = jsonDecode(txt.body);
    } else {
      // print(txt.statusCode);
    }
    // http.Client().close();
  } else if (m == mode[1]) {
    // final txt = await http.Client().get(Uri.parse(server));
    Map<String, String> body = {
      'mode': mode[1],
      'name': sharedata[1],
    };

    // int timeout = 5;
    // try {
    //   http.Response response = await http.get('someUrl').
    //       timeout(Duration(seconds: timeout));
    //   if (response.statusCode == 200) {
    //     // do something
    //   } else {
    //     // handle it
    //   }
    // }  on Error catch (e) {
    //   print('General Error: $e');
    // }

    // http.Client().close();
    final txt = await http.post(Uri.parse(server), body: body).timeout(const Duration(seconds: updatedelay));

    if (txt.statusCode == 200) {
      // datain = jsonDecode(txt.body);
      logarrray = jsonDecode(txt.body);
      // print("'" + txt.body + "'");
      // print(logarrray[9]);
      // print(logarrray.length);
      // print("yes");
      // return logarrray;
      // print(logarrray);
      logsize = logarrray.length;
      // print(logsize);
    } else {
      // print(txt.statusCode);
    }
  }
  // print(logarrray.length);
  http.Client().close();
}

//chart
const double chartw = 1800, charth = 500;
double xmax = 600;  //xmax must be more than logsize
