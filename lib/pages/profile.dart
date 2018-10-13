import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global.dart' as global;

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Recipes'),
          backgroundColor: global.Global().primaryColor,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: global.Global().textColor,
                displayColor: global.Global().textColor,
                fontFamily: 'Garamond',
              ),
        ),
        body: new SingleChildScrollView(
            child: Container(
                padding: new EdgeInsets.all(10.0),
                color: Colors.grey[200],
                child: new Column(children: <Widget>[
                  new Container(
                      child: new StreamBuilder(
                          stream: Firestore.instance
                              .collection("Profiles")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            else
                              return new Container(
                                  child: new Column(children: <Widget>[
                                Card(
                                    color: Theme.of(context).cardColor,
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          title: Text(
                                            'User Profile',
                                            textAlign: TextAlign.center,
                                            textScaleFactor: 1.5,
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(snapshot.data.documents[0]
                                              ['name']),
                                          subtitle: Text(snapshot
                                              .data.documents[0]['user id']),
                                          trailing: ImageIcon(
                                            AssetImage('assets/cup.png'),
                                            color: Color(0xFFf2b134),
                                          ),
                                        )
                                      ],
                                    )),
                                Card(
                                    child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        'Current Ranking',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.5,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        snapshot.data.documents[0]['rank'] +
                                            '/100',
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                )),
                              ]));
                          })),
                  new Container(
                      child: new StreamBuilder(
                    stream: Firestore.instance
                        .collection("Leaderboard")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return CircularProgressIndicator();
                      else
                        return new Container(
                            child: new Column(children: <Widget>[
                          Card(
                              child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  'Leaderboard',
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.5,
                                ),
                              ),
                              ListTile(
                                leading: ImageIcon(
                                  AssetImage('assets/first.png'),
                                  color: Color(0xFFf2b134),
                                ),
                                title: Text(snapshot.data.documents[0]['name']),
                                subtitle:
                                    Text(snapshot.data.documents[0]['points']),
                              ),
                              ListTile(
                                leading: ImageIcon(
                                  AssetImage('assets/second.png'),
                                  color: Color(0xFFf2b134),
                                ),
                                title: Text(snapshot.data.documents[1]['name']),
                                subtitle:
                                    Text(snapshot.data.documents[1]['points']),
                              ),
                              ListTile(
                                leading: ImageIcon(
                                  AssetImage('assets/third.png'),
                                  color: Color(0xFFf2b134),
                                ),
                                title: Text(snapshot.data.documents[2]['name']),
                                subtitle:
                                    Text(snapshot.data.documents[2]['points']),
                              ),
                            ],
                          ))
                        ]));
                    },
                  ))
                ]))));
  }
}
