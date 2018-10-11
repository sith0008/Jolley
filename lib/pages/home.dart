import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../global.dart' as global;
import './list.dart' as list;
import './recipe.dart' as recipe;
import './profiles.dart' as profiles;
import './qr_scanner.dart' as qr_scanner;

class Home extends StatefulWidget {
  Home({this.onSignedOut});
  final VoidCallback onSignedOut;
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<Home> with SingleTickerProviderStateMixin {
  final List<MyTabs> _tabs = [
    new MyTabs(title: "List"),
    new MyTabs(title: "Recipe"),
  ];

  String barcode = "";

  MyTabs handler;
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2, initialIndex: 0);
    handler = _tabs[1];
    controller.addListener(handleSelected);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleSelected() {
    setState(() {
      handler = _tabs[controller.index];
    });
  }
   void _showDialog() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'List Name', hintText: 'eg. Groceries List 1'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('SAVE'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Toshiba"),
            backgroundColor: global.Global().primaryColor,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: global.Global().textColor,
                  displayColor: global.Global().textColor,
                  fontFamily: 'Garamond',
                ),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.account_circle),
                color: global.Global().textColor,
                tooltip: 'Profiles',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => profiles.Profiles()));
                },
              ),
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (controller.index == 0) {
               _showDialog();
            }
            else if (controller.index == 1){
              scan();
            }
          },
          backgroundColor: global.Global().primaryColor,
          tooltip: 'Add',
          child: Icon(Icons.add),    
          elevation: 2.0,
        ),
        bottomNavigationBar: new Material(
          color: global.Global().primaryColor,
          child: new TabBar(
              controller: controller,
              tabs: <Tab>[
                new Tab(icon: new Icon(Icons.list)),
                new Tab(icon: new Icon(Icons.fastfood))
              ],
              indicatorColor: global.Global().textColor,
              labelColor: global.Global().textColor,
              unselectedLabelColor: Colors.grey),
        ),
        body: new TabBarView(controller: controller, children: <Widget>[
          new list.List(),
          new recipe.Recipe(),
        ]));
  }
    Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}

class MyTabs {
  final String title;
  MyTabs({this.title});
}
