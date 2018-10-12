import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global.dart' as global;
import './list.dart' as list;
import './recipe.dart' as recipe;
import './profiles.dart' as profiles;
// import './qr_scanner.dart' as qr_scanner;

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
  // String get qr_barcode {
  //   return barcode;
  // }

  String recipe_name;
  String items;

  MyTabs handler;
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2, initialIndex: 0);
    handler = _tabs[1];
    controller.addListener(handleSelected);
    // getData().then((results) {
    //   setState(() {
    //     recipe_name = results;
    //   });
    // });
    // getData2().then((results) {
    //   setState(() {
    //     items = results;
    //   });
    // });
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

  String listName;
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
                    onChanged: (String name) {
                      listName = name;
                    },
                    decoration: new InputDecoration(
                        labelText: 'List Name',
                        hintText: 'eg. Groceries List 1'),
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
                    DocumentReference documentReference = Firestore.instance
                        .collection('Profiles')
                        .document('Jay Sean')
                        .collection('Personal')
                        .document(listName);
                    Map<String, String> listData = <String, String>{
                      "Name": listName,
                      "Items": "0",
                    };
                    documentReference
                        .setData(listData, merge: true)
                        .whenComplete(() {
                      print("list created");
                      //print(count.toString());
                      //print(prevMessage);
                    }).catchError((e) => print(e));
                    Navigator.pop(context);
                  })
            ],
          ),
    );
  }

  getData() async {
    return await Firestore.instance
        .collection('Recipe')
        .document('Curry Chicken')
        .get()
        .then((docSnap) {
      var recipeName = docSnap.data['name'];
      assert(recipeName is String);
      return recipeName;
    });
  }

    getData2() async {
    return await Firestore.instance
        .collection('Recipe')
        .document('Curry Chicken')
        .get()
        .then((docSnap) {
      var recipeItem = docSnap.data['items'];
      assert(recipeItem is String);
      return recipeItem;
    });
  }

  storeData() {
    print('storing data');
    print(getData());
    recipe_name = getData();
    print(recipe_name);
    items = getData2();
    if (recipe_name == barcode) {
      DocumentReference documentReference = Firestore.instance
          .collection('Profiles')
          .document('Jay Sean')
          .collection('Recipe')
          .document();
      Map<String, String> recipeData = <String, String>{
        "Name": recipe_name,
        "Items": items,
      };
      documentReference.setData(recipeData, merge: true).whenComplete(() {
        print("recipe created");
        //print(count.toString());
        //print(prevMessage);
      }).catchError((e) => print(e));
    }
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
            } else if (controller.index == 1) {
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
      print(barcode);
      storeData();
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}

class MyTabs {
  final String title;
  MyTabs({this.title});
}
