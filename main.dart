import 'package:flutter/material.dart';
// import 'login.dart';
import 'package:rellab/machinestatus_type.dart';
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
          scaffoldBackgroundColor: Colors.white,
          // primaryColor: primeColor,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.white),
            backgroundColor: Colors.black,
          )),
      home: const MACHINESTATUSTYPE(),
    );
  }
}
