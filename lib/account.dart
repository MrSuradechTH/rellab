import 'package:flutter/material.dart';

class ACCOUNT extends StatefulWidget {
  const ACCOUNT({Key? key}) : super(key: key);

  @override
  State<ACCOUNT> createState() => _ACCOUNTState();
}

class _ACCOUNTState extends State<ACCOUNT> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // children: <Widget>[
          //   const Text(
          //     'You have pushed the button this many times:',
          //   ),
          //   Text(
          //     '$_counter',
          //     style: Theme.of(context).textTheme.headline4,
          //   ),
          // ],
          children: <Widget>[
            Text(
              'Building',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}