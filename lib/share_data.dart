//jsonget
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//machine menu
final List<String> machinestatustype = [
  "TEMPCYCLE",
  "TEMPHUMID",
  "ENDURANCE",
  "BURNIN",
  "BAKE"
];
final List<List<String>> machinestatusname = [
  [
    "TEMPCYCLE#01",
    "TEMPCYCLE#02",
    "TEMPCYCLE#03",
    "TEMPCYCLE#04",
    "TEMPCYCLE#05"
  ],
  [
    "TEMPHUMID#01",
    "TEMPHUMID#02",
    "TEMPHUMID#03",
    "TEMPHUMID#04",
    "TEMPHUMID#05"
  ],
  [
    "ENDURANCE#01",
    "ENDURANCE#02",
    "ENDURANCE#03",
    "ENDURANCE#04",
    "ENDURANCE#05"
  ],
  ["BURNIN#01", "BURNIN#02", "BURNIN#03", "BURNIN#04", "BURNIN#05"],
  ["BAKE#01", "BAKE#02", "BAKE#03", "BAKE#04", "BAKE#05"],
];
final List<String> sharedata = [
  "",
  ""
]; //0 save number wait for back 1 save any value to use

//jsonget
String server = 'http://127.0.0.1/jsonget.php';
List<dynamic> mode = ["monitor"];
Map<dynamic, dynamic> datain = {};
// List<List<dynamic>> dataneed = [[],[],[]]; //array
Future getdata(String m) async {
  if (m == mode[0]) {
    // final txt = await http.Client().get(Uri.parse(server));
    Map<String, String> body = {
      'mode': mode[0],
      'name': sharedata[1],
    };
    final txt = await http.post(
      Uri.parse(server),
      body: body,
    );

    print(jsonDecode(txt.body));
    datain = jsonDecode(txt.body);
    // if (kDebugMode) {
    //   print(
    //       '${datain['name']} : ${datain['temp']}  : ${datain['humid']}  : ${datain['time']}\n');
    // }
  }
  http.Client().close();
}
