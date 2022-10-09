import 'package:flutter/material.dart';
import 'package:rellab/chart.dart';
import 'package:rellab/machinestatus_share.dart';

class MACHINESTATUSNAME extends StatefulWidget {
  const MACHINESTATUSNAME( {Key? key}) : super(key: key);

  @override
  State<MACHINESTATUSNAME> createState() => MACHINESTATUSNAMEState();
}

class MACHINESTATUSNAMEState extends State<MACHINESTATUSNAME> {
  Widget name(int i) {
    print("machinestatusname[int.parse(sharedata[0])][i]");
      return Container(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          child: Text(machinestatusname[int.parse(sharedata[0])][i],style: const TextStyle(fontSize: 10),textAlign: TextAlign.center,),
          onPressed: () {
            sharedata[1] = machinestatusname[int.parse(sharedata[0])][i];
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
          }
        ),
      );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MACHINE STATUS"),
        automaticallyImplyLeading: false,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          for (int i = 0;i  < machinestatusname[int.parse(sharedata[0])].length;i++) name(i),
        ],
      ),
    );
  }
}