import 'package:flutter/material.dart';
import 'package:newloginpage/screen/login.dart';
import 'package:newloginpage/screen/signUp.dart';


class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  bool isCheckedLogin = false;
  bool isCheckedSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 270.0),
              Text(
                "Welcome",
                style: TextStyle(color: Colors.purple, fontSize: 66),
              ),
              Text("To Login page"),
              SizedBox(height: 30.0),
              Text("Please Login or Sign Up to continue"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isCheckedLogin = true;
                          isCheckedSignUp = false;
                        });
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color:
                              isCheckedLogin ? Colors.white : Colors.purple,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.purple),
                        primary:
                            isCheckedLogin ? Colors.purple : Colors.white,
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isCheckedSignUp = true;
                        isCheckedLogin = false;
                      });
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color:
                            isCheckedSignUp ? Colors.white : Colors.purple,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      primary:
                          isCheckedSignUp ? Colors.purple : Colors.white,
                      shape: StadiumBorder(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
