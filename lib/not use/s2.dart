import 'package:flutter/material.dart';
import 'S1.dart';

void main() => runApp(S2());

class S1 extends StatelessWidget {
  const S1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 's2',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: START(),
    );
  }
}

class START extends StatefulWidget {
  const START({Key? key}) : super(key: key);
  _STARTState createState() => _STARTState();
}

class _STARTState extends State<START> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YESYsssss'),
      ),
      body: Center(
          child: Column(
        children: [Text('yes bro')],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MyClass())),
        hoverColor: Colors.blue,
        child: const Text('change'),
      ),
    );
  }
}
