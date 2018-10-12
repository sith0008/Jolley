import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global.dart' as global;
// import './home.dart' as home;

class RecipeInstructions extends StatelessWidget {
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
              radius: 24.0,
            ),
            title: new Text(document['instruction'])),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Curry Chicken'),
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
                                      child: new Text('Instructions',
                                          style: new TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold))),
                                  flex: 4),
                              new Expanded(
                                  child: new IconButton(
                                      icon: new Icon(Icons.list),
                                      onPressed: () {}),
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
