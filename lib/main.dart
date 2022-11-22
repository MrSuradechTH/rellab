import 'package:flutter/material.dart';
import 'login.dart';
import 'package:rellab/share_data.dart';

void main() {
  runApp(const MAIN());
}

class MAIN extends StatelessWidget {
  const MAIN({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: background,
        // primaryColor: primeColor,
      ),
      home: const LOGIN(),
    );
  }
}