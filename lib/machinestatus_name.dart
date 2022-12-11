import 'package:flutter/material.dart';
import 'package:rellab/chart.dart';
import 'package:rellab/share_data.dart';

class MACHINESTATUSNAME extends StatefulWidget {
  const MACHINESTATUSNAME({Key? key}) : super(key: key);

  @override
  State<MACHINESTATUSNAME> createState() => MACHINESTATUSNAMEState();
}

class MACHINESTATUSNAMEState extends State<MACHINESTATUSNAME> {
  Widget name(int i) {
    // print("machinestatusname[int.parse(sharedata[0])][i]");
    return Container(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
          child: Container(
            padding: const EdgeInsets.only(top: 25.0),
            child: Center(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.center,
                  ),
                  Text(
                    machinestatusname[int.parse(sharedata[0])][i],
                    style: const TextStyle(fontSize: menufontsize),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          onPressed: () {
            sharedata[1] = machinestatusname[int.parse(sharedata[0])][i];
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CHART()));
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MACHINE STATUS"),
        automaticallyImplyLeading: true,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: GridView.count(
        crossAxisCount: menux,
        children: [
          for (int i = 0;i < machinestatusname[int.parse(sharedata[0])].length;i++)name(i),
        ],
      ),
    );
  }
}
