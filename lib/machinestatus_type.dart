import 'package:flutter/material.dart';
import 'package:rellab/machinestatus_name.dart';
import 'package:rellab/share_data.dart';

class MACHINESTATUSTYPE extends StatefulWidget {
  const MACHINESTATUSTYPE({Key? key}) : super(key: key);
  @override
  State<MACHINESTATUSTYPE> createState() => _MACHINESTATUSTYPEState();
}

class _MACHINESTATUSTYPEState extends State<MACHINESTATUSTYPE> {
  Widget type(int i) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
          child: Text(
            machinestatustype[i],
            style: const TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            sharedata[0] = i.toString();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MACHINESTATUSNAME()));
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MACHINE STATUS"),
        automaticallyImplyLeading: true,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          for (int i = 0; i < machinestatustype.length; i++) type(i),
        ],
      ),
    );
  }
}
