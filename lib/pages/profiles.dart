import 'package:flutter/material.dart';
import '../global.dart' as global;


class Profiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Profiles"),
            backgroundColor: global.Global().primaryColor,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: global.Global().textColor,
                  displayColor: global.Global().textColor,
                  fontFamily: 'Garamond',
                ),
        ),
            body: new Text("Profiles page")

    );
  }
}