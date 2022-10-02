import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rellab/home.dart';
import 'package:rellab/register.dart';

void main() => runApp(const LOGIN());

class Logindata {
  static String? username;
  static String? password;
}


class LOGIN extends StatefulWidget {
  const LOGIN({Key? key}) : super(key: key);

  @override
  State<LOGIN> createState() => _LOGINState();
}

class _LOGINState extends State<LOGIN> {

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Username"),
                TextFormField(
                  onSaved: (newdata) {
                    Logindata.username = newdata;
                  },
                ),
                const SizedBox(height: 20,),
                const Text("Password"),
                TextFormField(
                  onSaved: (newdata) {
                    Logindata.password = newdata;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text("LOGIN"),
                    onPressed: () {
                      formkey.currentState?.save();
                      if (Logindata.username == "Art" && Logindata.password == "1234") {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                              title: Text("Login Success!!!"),
                              content: Text("Welcome to RELLAB"),
                            ),
                        );
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          setState(() {
                            Navigator.of(context).canPop()?Navigator.of(context).pop():null;
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HOME()));
                          });
                        });
                        formkey.currentState?.reset();
                      }else {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                              title: Text("Login Fail!!!"),
                              content: Text("Please try again"),
                            ),
                        );
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          setState(() {
                            Navigator.of(context).canPop()?Navigator.of(context).pop():null;
                          });
                        });
                        formkey.currentState?.reset();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text("REGISTER"),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const REGISTER()));
                    },
                  ),
                ),
              ],
            ), 
          ),
        ),
      ),
    );
  }
}
