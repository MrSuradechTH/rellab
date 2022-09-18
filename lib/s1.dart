// import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';
import 's2.dart';

void main() => runApp(MyClass());

class MyClass extends StatelessWidget {
  const MyClass({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TEST',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MySum(title: 'TEST'),
      // home: S1(),
    );
  }
}

class MySum extends StatefulWidget {
  final String title;
  const MySum({Key? key, required this.title}) : super(key: key);
  _MySumState createState() => _MySumState();
}

class _MySumState extends State<MySum> {
  int number = 0;
  void sum_void() {
    setState(() {
      number++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COUNT'),
      ),
      body: Center(
          child: Column(
        // scrollDirection: Axis.horizontal, //ListView
        // direction: Axis.horizontal, //Wrap
        children: [
          Text('Tests count result is $number'),
          Wrap(
            direction: Axis.horizontal,
            children: [
              Container(
                // child: Align(
                //   alignment: Alignment.bottomCenter,
                // height: 50,
                // width: 50,
                margin:
                    EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 20),
                child: FloatingActionButton(
                  onPressed: sum_void,
                  hoverColor: Colors.blue,
                  child: Text('count',
                      style: TextStyle(fontSize: 13, color: Colors.black)),
                ),
                // ),
              ),
              Container(
                // child: Align(
                //   alignment: Alignment.bottomCenter,
                // height: 50,
                // width: 50,
                margin:
                    EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 20),
                child: FloatingActionButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const S2())),
                  hoverColor: Colors.blue,
                  child: Text('change',
                      style: TextStyle(fontSize: 13, color: Colors.black)),
                ),
                // ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
