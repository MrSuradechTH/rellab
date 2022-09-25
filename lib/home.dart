import 'package:flutter/material.dart';
import 'package:rellab/account.dart';
import 'package:rellab/machinestatus.dart';

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
      body: const DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              MACHINESTATUS(),
              ACCOUNT(),
            ],
          ),
          backgroundColor: Colors.red,
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(text: "MACHINE STATUS",),
              Tab(text: "ACCOUNT",),
            ],
          ),
        )
      ),
    );
  }
}
