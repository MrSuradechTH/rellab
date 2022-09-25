import 'package:flutter/material.dart';
import 'package:rellab/chart.dart';

class MACHINESTATUS extends StatefulWidget {
  const MACHINESTATUS({Key? key}) : super(key: key);

  @override
  State<MACHINESTATUS> createState() => _MACHINESTATUSState();
}

class _MACHINESTATUSState extends State<MACHINESTATUS> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text("TEMPCYCLE#01",style: TextStyle(fontSize: 10),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text("TEMPCYCLE#01",style: TextStyle(fontSize: 10),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text("TEMPCYCLE#01",style: TextStyle(fontSize: 10),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text("TEMPCYCLE#01",style: TextStyle(fontSize: 10),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text("TEMPCYCLE#01",style: TextStyle(fontSize: 10),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text("TEMPCYCLE#01",style: TextStyle(fontSize: 10),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text("TEMPCYCLE#01",style: TextStyle(fontSize: 10),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text("TEMPCYCLE#01",style: TextStyle(fontSize: 10),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text("TEMPCYCLE#01",style: TextStyle(fontSize: 10),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text("TEMPCYCLE#01",style: TextStyle(fontSize: 10),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text("TEMPCYCLE#01",style: TextStyle(fontSize: 10),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text("TEMPCYCLE#01",style: TextStyle(fontSize: 10),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
              },
            ),
          ),
        ],
      ),
    );
  }
}