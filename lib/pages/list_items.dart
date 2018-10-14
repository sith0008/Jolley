import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global.dart' as global;
import './add_list.dart' as add_list;
import './saved_recipes.dart' as saved_recipe;

class ListItems extends StatefulWidget {
  final String lists;
  ListItems(this.lists);
  @override
  _ListItemsState createState() => new _ListItemsState(lists);
}

class _ListItemsState extends State<ListItems> {
  final String lists1;
  _ListItemsState(this.lists1);
  Future<Null> _showDialog() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: const Text('Select list to add from:'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => add_list.AddList()));
                  },
                  child: const Text('Shop Catalogue'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => saved_recipe.SaveRecipe()));
                  },
                  child: const Text('Saved Recipes'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(lists1),
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
                  .document(lists1)
                  .collection('items')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return new ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    padding: const EdgeInsets.only(top: 10.0),
                    itemBuilder: (context, index) {
                      String listItem = snapshot.data.documents[index]['name'];
                      return new Container(
                          child: new Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                              child: new CheckboxListTile(
                                  title: Text(listItem),
                                  subtitle: new Text("Quantity: " +
                                      snapshot.data.documents[index]
                                          ['quantity']),
                                  secondary: CircleAvatar(
                                      backgroundImage: new NetworkImage(snapshot
                                          .data.documents[index]['image']),
                                      radius: 24.0),
                                  value: snapshot.data.documents[index]
                                      ['checked'],
                                  onChanged: (bool value) {
                                    setState(() {
                                      String number = (index + 1).toString();
                                      DocumentReference itemRef =
                                          Firestore.instance.document(
                                              "Profiles/Jay Sean/Personal/" + lists1 + "/items/item" +
                                                  number);
                                      Map<String, bool> data = <String, bool>{
                                        "checked": value,
                                      };
                                      itemRef
                                          .setData(data, merge: true)
                                          .whenComplete(() {})
                                          .catchError((e) => print(e));
                                    });
                                  })));
                    });
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
