
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  String email = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _Email = TextEditingController();

  bool showText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgotten Screen"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 20, left: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "We will send you a link.... Please click on that link to reset your password",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                Theme(
                  data: ThemeData(
                    hintColor: Colors.purple,
                  ),
                  child: TextFormField(
                    controller: _Email,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter your E-Mail";
                      } else {
                        email = value;
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "E-Mail",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.purple,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.purple, width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.purple, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.purple, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.purple, width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  height: 55,
                  child: ElevatedButton(
                    child: Text("Reset"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email)
                            .then((value) => print("Check Your Mail"));
                        _Email.clear();
                        setState(() {
                          showText = true;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      primary: Colors.purple,
                      shape: StadiumBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                showText
                    ? Text(
                        "Please Check Your Email for Link",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold,color: Colors.purple),
                      )
                    : Text(""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
