import 'package:flutter/material.dart';
import '../global.dart' as global;
import './list.dart' as list;
import './recipe.dart' as recipe;

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
            title: new Text(handler.title),
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
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => profiles.Profiles()));
                },
              ),
            ]),
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
                unselectedLabelColor: Colors.grey)),
        body: new TabBarView(controller: controller, children: <Widget>[
          // new announce.Announce(),
          // new match.Match(),
        ]));
  }
}

class MyTabs {
  final String title;
  MyTabs({this.title});
}
