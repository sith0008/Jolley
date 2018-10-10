import 'package:flutter/material.dart';
import './home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Username can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  String _username;
  String _password;
  FirebaseUser currentUser;
  SharedPreferences prefs;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Invalid"),
          content: new Text(
              "You have entered an incorrect username or password"),
          actions: <Widget>[
            // buttons at bottom of dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        // prefs = await SharedPreferences.getInstance();
        FirebaseUser firebaseUser = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _username, password: _password);
        print('Signed in: $firebaseUser');
        // {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (BuildContext context) => Home(),
        //     ),
        //   );
        // }
      } catch (e) {
        print('Error: $e');
        _showDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
            color: Colors.white,
            alignment: FractionalOffset.center,
            child: new Center(
                child: ListView(children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 60.0,
                child: Image.asset('assets/trolley_logo.png'),
              ),
              Container(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: buildInputs() + buildSubmitButtons(),
                      )))
            ]))));
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        key: Key('username'),
        decoration: InputDecoration(labelText: 'Username'),
        validator: EmailFieldValidator.validate,
        onSaved: (value) => _username = value,
      ),
      TextFormField(
        key: Key('password'),
        decoration: InputDecoration(labelText: 'Password'),
        validator: PasswordFieldValidator.validate,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    {
      return [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
            borderRadius: BorderRadius.circular(30.0),
            shadowColor: Colors.lightBlueAccent.shade100,
            elevation: 5.0,
            child: MaterialButton(
              minWidth: 200.0,
              height: 42.0,
              onPressed: () {
                validateAndSubmit();
              },
              color: Color(0xFFED1B24),
              child: Text('Log In', style: TextStyle(color: Colors.white)),
            ),
          ),
        )
      ];
    }
  }
}
