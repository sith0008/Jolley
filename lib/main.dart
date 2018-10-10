import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/login_page.dart';
import './auth.dart';
import './auth_provider.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MaterialApp(home: new App()));
  });
}

class App extends StatelessWidget {
  final themeColor = new Color(0xffED1B24);
  final primaryColor1 = new Color(0xffED1B24);
  Color get primaryColor {
    return primaryColor1;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AirVenue',
        home: LoginPage(),
    );
  }
}