import 'package:flutter/material.dart';

//them
//---menu
// double width = MediaQuery.of(context).size.width,height = MediaQuery.of(context).size.height;
dynamic background = Colors.grey;
const double menufontsize = 20;
List<String> fontstring = ["Righteous-Regular"];
List<TextStyle> font = [const TextStyle(fontFamily: "Righteous-Regular",fontSize: 30),const TextStyle(fontFamily: "Righteous-Regular",fontSize: 20)];
//---chart
List<double> screensize = [0,0]; //w,h
List<int> intervalvalue = [60,10]; //[x,(1-20)]
BoxConstraints ?layoutdata;

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

bool humidmachine = machinestatustype[int.parse(sharedata[0])].contains("TEMPHUMID");

//json get
String server = 'http://127.0.0.1/json.php';