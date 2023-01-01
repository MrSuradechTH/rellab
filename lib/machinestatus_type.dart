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
      padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),
      child: ElevatedButton(
        // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(97, 0, 255, 132))),
        child: Text(
          machinestatustype[i],
          style: const TextStyle(fontSize: menufontsize),
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          sharedata[0] = i.toString();
          humidmachine = machinestatustype[int.parse(sharedata[0])].contains("TEMPHUMID");
          Navigator.push(context,MaterialPageRoute(builder: (context) => const MACHINESTATUSNAME()));
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MACHINE STATUS"),
        automaticallyImplyLeading: true,
        // leading: const BackButton(
        //   color: Colors.white,
        // ),
      ),
      body: GridView.count(
        crossAxisCount: menux,
        children: [
          for (int i = 0; i < machinestatustype.length; i++) type(i),
        ],
      ),
    );
  }
}
