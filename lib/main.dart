import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const MAIN());
}

class MAIN extends StatelessWidget {
  const MAIN({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LOGIN(),
    );
  }
}