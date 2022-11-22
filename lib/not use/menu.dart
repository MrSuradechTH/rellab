import 'package:flutter/material.dart';
import 'package:rellab/login.dart';
import 'package:rellab/home.dart';

void main() => runApp(const LOGIN());

class LOGIN extends StatelessWidget {
  const LOGIN({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOGIN',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('LOGIN'),
        ),
        body: const LOGINS(),
      ),
    );
  }
}

class LOGINS extends StatefulWidget {
  const LOGINS({Key? key}) : super(key: key);

  @override
  State<LOGINS> createState() => _LOGINSState();
}

class _LOGINSState extends State<LOGINS> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              Container(),
              Container(),
            ],
          ),
          backgroundColor: Colors.red,
          bottomNavigationBar: const TabBar(
            tabs: [
              Tab(text: "LOGIN",),
              Tab(text: "REGISTER",),
            ],
          ),
        )
      ),
    );
  }
}
