import 'package:flutter/material.dart';
import 'package:rellab/account.dart';
import 'package:rellab/machinestatus_type.dart';
import 'package:rellab/share_data.dart';

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
        automaticallyImplyLeading: true,
      ),
      body: GridView.count(crossAxisCount: menux, children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            child: const Text(
              "MACHINE\nSTATUS",
              style: TextStyle(fontSize: menufontsize),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MACHINESTATUSTYPE()));
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            child: const Text(
              "ACCOUNT",
              style: TextStyle(fontSize: menufontsize),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ACCOUNT()));
            },
          ),
        ),
      ]),
    );
  }
}
