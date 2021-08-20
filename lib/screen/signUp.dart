
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newloginpage/screen/login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _Email = TextEditingController();
  final TextEditingController _Name = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  String _name, _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
        _Email.clear();
        _Name.clear();
        _pass.clear();
        _confirmPass.clear();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);

        if (user != null) {
          await _auth.currentUser.updateDisplayName(_name);
        }
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToSignIn() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.pink[600]),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                                validator: (input) {
                                  if (input.isEmpty) return 'Enter Name';
                                  return null;
                                },
                                controller: _Name,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'Name',
                                  prefixIcon: Icon(Icons.person,color: Colors.purple,),
                                ),
                                onSaved: (input) => _name = input),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: TextFormField(
                              controller: _Email,
                                validator: (input) {
                                  if (input.isEmpty) return 'Enter Email';
                                  return null;
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(color: Colors.purple),
                                    ),
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email,color: Colors.purple,)),
                                onSaved: (input) => _email = input),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: TextFormField(
                              controller: _pass,
                                validator: (input) {
                                  if (input.length < 6)
                                    return 'Provide Minimum 6 Character';
                                  return null;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock,color: Colors.purple,),
                                ),
                                obscureText: true,
                                onSaved: (input) => _password = input),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: TextFormField(
                              controller: _confirmPass,
                                validator: (input) {
                                  if(input != _pass.text)
                                    return "Password not match";
                                  return null;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'Confirm Password',
                                  prefixIcon: Icon(Icons.lock,color: Colors.purple,),
                                ),
                                obscureText: true,
                                onSaved: (input) => _password = input),
                          ),
                          SizedBox(height: 40),
                          SizedBox(
                            width: 200,
                            height: 55,
                            child: ElevatedButton(
                              child: Text("SignUp"),
                              onPressed: signUp,
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(color: Colors.purple),
                                primary: Colors.purple,
                                shape: StadiumBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already Have an Account...?",
                                style: TextStyle(
                                     color: Colors.black),
                              ),
                              GestureDetector(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.purple, fontSize: 20),
                                ),
                                onTap: navigateToSignIn,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
