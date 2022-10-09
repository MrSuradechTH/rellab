import 'package:flutter/material.dart';
import 'package:rellab/account.dart';
import 'package:rellab/machinestatus_type.dart';

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


// child: Navigator(
          //   onGenerateRoute: (settings) {
          //     if (settings.name == 'CHART') {
          //       // return MaterialPageRoute(builder: (_) => const CHART());
          //       // Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
          //     }else if (settings.name == 'MACHINESTATUS') {
          //       return MaterialPageRoute(builder: (_) => const ACCOUNT());
          //     }else {
          //       return MaterialPageRoute(builder: (_) => const MACHINESTATUS());
          //     }
          //     return null;
          //   },
          // ),