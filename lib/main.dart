import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/login_page.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MaterialApp(home: new App()));
  });
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Toshiba',
        home: LoginPage(),
    );
  }
}