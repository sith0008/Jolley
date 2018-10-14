import 'package:flutter/material.dart';
import '../global.dart' as global;
import './parent_view.dart' as parent_view;
import './game_home.dart' as game_home;
import './profile.dart' as profile;

class Home extends StatefulWidget {
  Home({this.onSignedOut});
  final VoidCallback onSignedOut;
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<Home> with SingleTickerProviderStateMixin {
  final List<MyTabs> _tabs = [
    new MyTabs(title: "Parent"),
    new MyTabs(title: "Kids"),
  ];

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          bottom: new TabBar(
              controller: controller,
              tabs: <Tab>[
                new Tab(text: 'Parent'),
                new Tab(text: 'Kids')
              ],
              indicatorColor: global.Global().textColor,
              labelColor: global.Global().textColor,
              unselectedLabelColor: Colors.grey),
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
                          builder: (context) => profile.Profile()));
                },
              ),
            ],),
        body: new TabBarView(controller: controller, children: <Widget>[
          new parent_view.ParentView(),
          new game_home.GameHome(),
        ]));
  }
}

class MyTabs {
  final String title;
  MyTabs({this.title});
}
