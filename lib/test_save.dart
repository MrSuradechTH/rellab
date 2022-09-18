import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('D\'Chart')),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Line Chart'),
              tileColor: Colors.amber[200],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const RotatedBox(quarterTurns: 3, child: Text('Temp')),
                  // SizedBox(width: 5,height: 2,),
                  Expanded(
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 15 / 9,
                          child: DChartLine(
                            lineColor: (lineData, index, id) {
                              return id == 'Line 1'
                                  ? Colors.blue
                                  : Colors.amber;
                            },
                            // ignore: prefer_const_literals_to_create_immutables
                            data: [
                              // ignore: prefer_const_literals_to_create_immutables
                              {
                                'id': 'Line 2',
                                'data': const [
                                  {'domain': 0, 'measure': 4},
                                  {'domain': 2, 'measure': 2},
                                  {'domain': 3, 'measure': 2},
                                  {'domain': 4, 'measure': 1},
                                  {'domain': 5, 'measure': 2.5},
                                ],
                              },
                            ],
                            includePoints: true,
                          ),
                        ),
                        const Text('Time'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}