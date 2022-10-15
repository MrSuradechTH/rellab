import 'package:flutter/material.dart';
import 'package:rellab/account.dart';
import 'package:rellab/machinestatus_type.dart';

class HOME extends StatefulWidget {
  const HOME({Key? key}) : super(key: key);

  @override
  State<HOME> createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        automaticallyImplyLeading: false,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              child: const Text("MACHINE\nSTATUS",style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MACHINESTATUSTYPE()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              child: const Text("ACCOUNT",style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ACCOUNT()));
              },
            ),
          ),
        ]
      ),
    );
  }
}