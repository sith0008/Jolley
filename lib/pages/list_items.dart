import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global.dart' as global;
import './list_items.dart' as list_items;

class ListItems extends StatelessWidget {
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text('Groceries List 1'),
            backgroundColor: global.Global().primaryColor,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: global.Global().textColor,
                  displayColor: global.Global().textColor,
                  fontFamily: 'Garamond',
                ),
        ),
                body: Container(
        child: new Container(
      child: new Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        child: new GestureDetector(
          onTap: () {
            Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => list_items.ListItems()));
          },
          child: new ListTile(
              title: new Text(document['Name']),
              subtitle: new Text("Items: " + document['Items']),
              trailing: new IconButton(
                icon: new Icon(Icons.videogame_asset),
                tooltip: 'Lists',
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => profiles.Profiles()));
                },
              )),
        ),
      ),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.grey[200],
        child: new StreamBuilder(
            stream: Firestore.instance
                .collection('Profiles')
                .document('Jay Sean')
                .collection('Personal')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.only(top: 10.0),
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data.documents[index]),
              );
            }));
  }
}
