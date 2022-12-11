//jsonget
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//them
dynamic background = Colors.grey;
dynamic menux = 5;
const double menufontsize = 20;

//machine menu
final List<String> machinestatustype = [
  // "TEMPCYCLE",
  "TEMPHUMID",
  // "ENDURANCE",
  "BURNIN",
  // "BAKE",
  // "HAST"
];
final List<List<String>> machinestatusname = [
  // [
  //   "TEMPCYCLE#01",
  //   "TEMPCYCLE#02",
  //   "TEMPCYCLE#03",
  //   "TEMPCYCLE#04",
  //   "TEMPCYCLE#05",
  //   "TEMPCYCLE#06",
  //   "TEMPCYCLE#07"
  // ],
  [
    "TEMPHUMID#01",
    "TEMPHUMID#02",
    "TEMPHUMID#03",
    "TEMPHUMID#04",
    "TEMPHUMID#05"
  ],
  // ["ENDURANCE#01", "ENDURANCE#02", "ENDURANCE#03", "ENDURANCE#04"],
  [
    "BURNIN#01",
    "BURNIN#02",
    "BURNIN#03",
    "BURNIN#04",
    "BURNIN#05",
    "BURNIN#06",
    "BURNIN#07",
    "BURNIN#08",
    "BURNIN#09",
    "BURNIN#10",
    "BURNIN#11",
    "BURNIN#12",
    "BURNIN#13",
    "BURNIN#14",
    "BURNIN#15",
    "BURNIN#16",
    "BURNIN#17",
    "BURNIN#18",
    "BURNIN#19"
  ],
  // ["BAKE#01", "BAKE#02", "BAKE#03"],
  // ["HAST#01", "HAST#02", "HAST#03", "HAST#04", "HAST#05", "HAST#06", "HAST#07"],
];
final List<String> sharedata = [
  "",
  ""
]; //0 save number wait for back 1 save any value to use

//jsonget
String server = 'http://127.0.0.1/json.php';
List<dynamic> mode = ["monitor", "log"];
Map<dynamic, dynamic> datain = {};
String timenow = "", lasttime = "";
const int updatedelay = 990;
List<dynamic> logarrray = [];
int logsize = 0;
bool chart_start = false;

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
    final txt = await http
        .post(
          Uri.parse(server),
          body: body,
        )
        .timeout(const Duration(seconds: updatedelay));

    if (txt.statusCode == 200) {
      // print(jsonDecode(txt.body));
      lasttime = timenow;
      datain = jsonDecode(txt.body);
      timenow = datain['time'];
      // sprintf("%s : %s", [lasttime,timenow]);
      if (lasttime == timenow) {
        getdata(m);
      } else {
        // if (kDebugMode) {
        // print('${datain['name']} : ${datain['temp']}  : ${datain['humid']}  : ${datain['time']}\n');
        // }
      }
    } else {
      print(txt.statusCode);
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
    final txt = await http
        .post(
          Uri.parse(server),
          body: body,
        )
        .timeout(const Duration(seconds: updatedelay));

    if (txt.statusCode == 200) {
      // datain = jsonDecode(txt.body);
      logarrray = jsonDecode(txt.body);
      // print("'" + txt.body + "'");
      // print(logarrray[9]);
      // print(logarrray.length);
      // print("yes");
      // return logarrray;
      logsize = logarrray.length;
      print(logsize);
    } else {
      print(txt.statusCode);
    }
  }
  // print(logarrray.length);
}

//chart
const double chartw = 1000, charth = 500;
double xmax = 600;  //xmax must be more than logsize
