import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'chart.dart';
void main() => runApp(const LOGIN());

class LOGIN extends StatelessWidget {
  const LOGIN({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOGIN',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
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
  List<String> label = ["username", "password"];
  List<String> user = ["", ""];
  void login(String userstr, String passstr) {
    setState(() {
      user[0] = userstr;
      user[1] = passstr;
      if (user[0] == "MrSuradechTH" && user[1] == "1234") {
        if (kDebugMode) {
          print(user[0]);
        }
        String str = "Hi Welcome to RELLAB";
        Text(str);
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
              title: Text("Login Success!!!"),
              content: Text("Welcome to RELLAB"),
          ),
        );
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const CHART()));
          });
        });
       
      } else {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
              title: Text("Login Fail!!!"),
              content: Text("Please try again"),
            ),
        );
        Navigator.of(context).pop();
        // Future.delayed(const Duration(milliseconds: 1000), () {
        //   setState(() {
        //     //  Navigator.push(context, MaterialPageRoute(builder: (context) => const LOGIN()));
            
        //   });
        // });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: username,
              decoration: InputDecoration(
                labelText: label[0],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: password,
              decoration: InputDecoration(
                labelText: label[1],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {
                login(username.text, password.text);
              },
              child: const Text('LOGIN'),
            ),
          ),
        ],
      ),
    );
  }
}
