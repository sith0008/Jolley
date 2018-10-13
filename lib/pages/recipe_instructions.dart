import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global.dart' as global;
// import './home.dart' as home;

class RecipeInstructions extends StatelessWidget {
    final String recipeName;
  RecipeInstructions(this.recipeName);
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return new Container(
        child: new Container(
      child: new Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        child: new ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: new NetworkImage(document['number']),
              radius: 20.0,
            ),
            title: new Text(document['instruction']),
            trailing: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: new NetworkImage(document['image']),
              radius: 20.0,
            ),),
      ),
    ));
  }

    Future<bool> infoDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Recipe Instructions"),
            content: new Text(
                "Follow the steps below with your family for some family fun cooking!"),
            actions: <Widget>[
              new FlatButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(recipeName),
          backgroundColor: global.Global().primaryColor,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: global.Global().textColor,
                displayColor: global.Global().textColor,
                fontFamily: 'Garamond',
              ),
        ),
        body: Container(
            color: Colors.grey[200],
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Expanded(
                      child: new Container(
                          padding: new EdgeInsets.only(top: 10.0),
                          child: new Card(
                              child: new Row(
                            children: <Widget>[
                              new Expanded(
                                  child: new Padding(
                                      padding: new EdgeInsets.all(8.0),
                                      child: new Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: new Text('Instructions',
                                              style: new TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontSize: 20.0,
                                                  fontWeight:
                                                      FontWeight.bold)))),
                                  flex: 4),
                              new Expanded(
                                  child: new IconButton(
                                      icon: new Icon(Icons.info),
                                      onPressed: () {
                                        infoDialog(context);
                                      }),
                                  flex: 1)
                            ],
                          ))),
                      flex: 1),
                  new Expanded(
                      child: new Container(
                          color: Colors.grey[200],
                          child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('Recipes')
                                  .document('recipe1')
                                  .collection('instructions')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return const Text('Loading...');
                                return new ListView.builder(
                                  itemCount: snapshot.data.documents.length,
                                  padding: const EdgeInsets.only(top: 10.0),
                                  itemBuilder: (context, index) =>
                                      _buildListItem(context,
                                          snapshot.data.documents[index]),
                                );
                              })),
                      flex: 5)
                ])));
  }
}
