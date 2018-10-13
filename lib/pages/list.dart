import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global.dart' as global;
import './list_items.dart' as list_items;
import './game_home.dart' as game_home;

class List extends StatefulWidget {
  @override
  _ListState createState() => new _ListState();
}

class _ListState extends State<List> {
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return new Container(
        child: new Container(
      child: new GestureDetector(
        onTap: () {
          String lists = document['Name'];
          print(lists);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => list_items.ListItems(lists)));
        },
        child: new Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: new ListTile(
              title: new Text(document['Name']),
              subtitle: new Text("Items: " + document['Items']),
              trailing: new IconButton(
                icon: new Icon(Icons.delete),
                tooltip: 'Delete',
                onPressed: () {
                  Firestore.instance.runTransaction((transaction) async {
                        DocumentSnapshot snapshot =
                            await transaction.get(document.reference);
                        await transaction.delete(snapshot.reference);
                  });
                },
              )),
        ),
      ),
    ));
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Grocery Lists'),
        backgroundColor: global.Global().primaryColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: global.Global().textColor,
              displayColor: global.Global().textColor,
              fontFamily: 'Garamond',
            ),
      ),
      body: Container(
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
                      _buildListItem(context, snapshot.data.documents[index])
                    );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        backgroundColor: global.Global().primaryColor,
        tooltip: 'Add',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}
