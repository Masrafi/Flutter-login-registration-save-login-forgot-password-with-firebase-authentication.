import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var _email = new TextEditingController();

  SharedPreferences logindata;
  String username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              Text(
                  'We will mail you a link ... please click in that link to reseat your password'),
              TextFormField(
                enabled: false,
                controller: _email,
                decoration: InputDecoration(
                  hintText: username,
                  // icon: Icon(Icons.location_on),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                      //borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                ),
              ),
              RaisedButton(
                child: Text("submit"),
                onPressed: () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: username)
                      .then((value) => print("Check your mail "));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
