import 'package:flutter/material.dart';
import 'package:rellab/login.dart';

void main() => runApp(const REGISTER());

class Registerdata {
  static String? username;
  static String? password;
}

class REGISTER extends StatefulWidget {
  const REGISTER({Key? key}) : super(key: key);

  @override
  State<REGISTER> createState() => _REGISTERState();
}

class _REGISTERState extends State<REGISTER> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REGISTER"),
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
                    Registerdata.username = newdata;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Password"),
                TextFormField(
                  onSaved: (newdata) {
                    Registerdata.password = newdata;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    child: const Text("REGISTER"),
                    onPressed: () {
                      formkey.currentState?.save();
                      if (Registerdata.username != "" &&
                          Registerdata.password != "") {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text("Register Success!!!"),
                            content: Text("Wait approve"),
                          ),
                        );
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          setState(() {
                            Navigator.of(context).canPop()
                                ? Navigator.of(context).pop()
                                : null;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LOGIN()));
                          });
                        });
                        formkey.currentState?.reset();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text("Register Fail!!!"),
                            content: Text("Please try again"),
                          ),
                        );
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          setState(() {
                            Navigator.of(context).canPop()
                                ? Navigator.of(context).pop()
                                : null;
                          });
                        });
                        formkey.currentState?.reset();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    child: const Text("LOGIN"),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LOGIN()));
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
