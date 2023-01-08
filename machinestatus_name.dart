import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rellab/chart.dart';
import 'package:rellab/share_data.dart';
import 'package:http/http.dart' as http;

class MACHINESTATUSNAME extends StatefulWidget {
  const MACHINESTATUSNAME({Key? key}) : super(key: key);

  @override
  State<MACHINESTATUSNAME> createState() => MACHINESTATUSNAMEState();
}

//jsonget
List<dynamic> mode = ["monitor"];
Map<dynamic, dynamic> datain = {};
List<List<List<dynamic>>> logarray = List.generate(machinestatustype.length, (i) => List.generate(machinemax(), (i) => [null,null,null,null,null,null]), growable: false);
const int updatedelay = 990,timetooffline = 60;
List<String> stringtime = ["Sec Ago","Min Ago\n🚨⚠️🚨","Hour Ago\n🚨⚠️🚨","Day Ago\n🚨⚠️🚨","Week Ago\n🚨⚠️🚨","Mounth Ago\n🚨⚠️🚨","Year Ago\n🚨⚠️🚨"];
List<Color> statuscolor = [const Color.fromARGB(255, 255, 17, 0),const Color.fromARGB(255, 0, 255, 8)];

class MACHINESTATUSNAMEState extends State<MACHINESTATUSNAME> {
  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: updatedelay), (timer) async {
      // logarray[0][0][0] = 1;
      // logarray[0][0][1] = 2;
      // logarray[1][0][0] = 1;
      // logarray[1][0][1] = 2;
      // print(machinestatustype.length);
      
      if (!mounted) {
        http.Client().close();
        return;
      }
      setState(() {
        // print(humidmachine.toString() + ":" + machinestatustype[int.parse(sharedata[0])]);
        // print(humidmachine);
        // print(machinestatustype[int.parse(sharedata[0])].contains("TEMPHUMID"));
        getdata(mode[0]);
      });
      // print(logarray);
      // print(logarray[0][0][2]);
    });
    super.initState();
  }

  Widget name(int i,double screensize) {
    print(screensize.toString() + " : " + (screensize).floor().toString());
    // print("machinestatusname[int.parse(sharedata[0])][i]");
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),
      child: ElevatedButton(
        // decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.pink, Colors.green])),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(statuscolor[logarray[int.parse(sharedata[0])][i][4] ?? 0])),
        child: Container(
          padding: const EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Align(
                  alignment: Alignment.center,
                ),
                if (humidmachine == false) Text(
                  "${machinestatusname[int.parse(sharedata[0])][i]}\n\n🌡️ ${logarray[int.parse(sharedata[0])][i][1]} °C\n⏱ ${logarray[int.parse(sharedata[0])][i][3]}  ${stringtime[logarray[int.parse(sharedata[0])][i][5] ?? 0]}",
                  style: font[1],
                  textAlign: TextAlign.center,
                )else if (humidmachine == true) Text(
                  "${machinestatusname[int.parse(sharedata[0])][i]}\n\n🌡️ ${logarray[int.parse(sharedata[0])][i][1]} °C\n💧 ${logarray[int.parse(sharedata[0])][i][2]} %RH\n⏱ ${logarray[int.parse(sharedata[0])][i][3]} ${stringtime[logarray[int.parse(sharedata[0])][i][5] ?? 0]}",
                  style: font[1],
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        onPressed: () {
          sharedata[1] = machinestatusname[int.parse(sharedata[0])][i];
          Navigator.push(context,MaterialPageRoute(builder: (context) => const CHART()));
        }),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<double> screensize = [0,0]; //w,h

    return Scaffold(
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
      body: LayoutBuilder(
        builder: (context, layoutdata) {
          return GridView.count(
            crossAxisCount: (layoutdata.maxWidth / 240).floor() <= 0 ? 1 : (layoutdata.maxWidth / 240).floor(),
            children: [
              for (int i = 0;i < machinestatusname[int.parse(sharedata[0])].length;i++)name(i,layoutdata.maxWidth),
            ],
          );
        },
      ),
    );
  }
}

//getdata
Future getdata(String m) async {
  if (m == mode[0]) {
    for(int i = 0;i < machinestatusname[int.parse(sharedata[0])].length;i++) {
      // logarray[i]['temp'] ? 0:0;
      // print(machinestatusname[int.parse(sharedata[0])].length);
      // print(sharedata[0]);
      Map<String, String> body = {
        'mode': mode[0],
        'name': machinestatusname[int.parse(sharedata[0])][i],
      };
      final txt = await http.post(Uri.parse(server), body: body).timeout(const Duration(seconds: updatedelay));

      if (txt.statusCode == 200) {
        datain = jsonDecode(txt.body);
        logarray[int.parse(sharedata[0])][i][0] = datain['name'];
        logarray[int.parse(sharedata[0])][i][1] = datain['temp'];
        logarray[int.parse(sharedata[0])][i][2] = datain['humid'];
        logarray[int.parse(sharedata[0])][i][3] = datain['time_stamp_seconds'];

        if (logarray[int.parse(sharedata[0])][i][3] > timetooffline) {
          logarray[int.parse(sharedata[0])][i][4] = 0;
        }else {
          logarray[int.parse(sharedata[0])][i][4] = 1;
        }

        if (logarray[int.parse(sharedata[0])][i][3] > 60*60*24*365) {
          logarray[int.parse(sharedata[0])][i][3] = (logarray[int.parse(sharedata[0])][i][3] / (60*60*24*365)).toStringAsFixed(2);
          logarray[int.parse(sharedata[0])][i][5] = 6;
        }else if (logarray[int.parse(sharedata[0])][i][3] > 60*60*24*30) {
          logarray[int.parse(sharedata[0])][i][3] = (logarray[int.parse(sharedata[0])][i][3] / (60*60*24*30)).toStringAsFixed(2);
          logarray[int.parse(sharedata[0])][i][5] = 5;
        }else if (logarray[int.parse(sharedata[0])][i][3] > 60*60*24*7) {
          logarray[int.parse(sharedata[0])][i][3] = (logarray[int.parse(sharedata[0])][i][3] / (60*60*24*7)).toStringAsFixed(2);
          logarray[int.parse(sharedata[0])][i][5] = 4;
        }else if (logarray[int.parse(sharedata[0])][i][3] > 60*60*24) {
          logarray[int.parse(sharedata[0])][i][3] = (logarray[int.parse(sharedata[0])][i][3] / (60*60*24)).toStringAsFixed(2);
          logarray[int.parse(sharedata[0])][i][5] = 3;
        }else if (logarray[int.parse(sharedata[0])][i][3] > 60*60) {
          logarray[int.parse(sharedata[0])][i][3] = (logarray[int.parse(sharedata[0])][i][3] / (60*60)).toStringAsFixed(2);
          logarray[int.parse(sharedata[0])][i][5] = 2;
        }else if (logarray[int.parse(sharedata[0])][i][3] > 60) {
          logarray[int.parse(sharedata[0])][i][3] = (logarray[int.parse(sharedata[0])][i][3] / 60).toStringAsFixed(2);
          logarray[int.parse(sharedata[0])][i][5] = 1;
        }else {
          logarray[int.parse(sharedata[0])][i][5] = 0;
        }
        // int a = logarray[int.parse(sharedata[0])][i][4];
        // print(a + 5);
        // print(logarray[int.parse(sharedata[0])][i][4].toString());
        // print(datain['temp']);
        // print(logarray[int.parse(sharedata[0])][j]);

        // print(logarray); //********
        
        // logarray[0] = "datain['temp'].toString()";
        // logarray[i][1] = datain['humid'].toString();
        // logarray[i][2] = datain['time'].toString();
        
        
      } else {
        // print(txt.statusCode);
      }
    }
  }
  http.Client().close();
}

machinemax() {
  int machinemax = 0;
  for(int i = 0;i < machinestatusname.length;i++) {
    if (machinemax < machinestatusname[i].length) {
      machinemax = machinestatusname[i].length;
    }
  }
  return machinemax;
}