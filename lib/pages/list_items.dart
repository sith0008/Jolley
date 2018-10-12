import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global.dart' as global;
import './add_list.dart' as add_list;

class ListItems extends StatelessWidget {
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return new Container(
        child: new Container(
            child: new Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
      child: new ListTile(
        leading: CircleAvatar(
          backgroundImage: new NetworkImage(document['image']),
          radius: 24.0,
        ),
        title: new Text(document['name']),
        subtitle: new Text("Quantity: " + document['quantity']),
        trailing: new Container(
          height: 40.0,
          width: 96.0,
          child: Row(
          children: <Widget>[

            new IconButton(
                icon: new Icon(Icons.delete),
                tooltip: 'Delete',
                iconSize: 20.0,
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => profiles.Profiles()));
                }),
            new IconButton(
              icon: new Icon(Icons.check_box),
              tooltip: 'checked_box',
              iconSize: 20.0,
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => profiles.Profiles()));
              },
            )
          ],
        ),
      ),
    ))));
  }

  @override
  Widget build(BuildContext context) {
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
          color: Colors.grey[200],
          child: new StreamBuilder(
              stream: Firestore.instance
                  .collection('Profiles')
                  .document('Jay Sean')
                  .collection('Personal')
                  .document('List1')
                  .collection('items')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  padding: const EdgeInsets.only(top: 10.0),
                  itemBuilder: (context, index) =>
                      _buildListItem(context, snapshot.data.documents[index]),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                          Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => add_list.AddList()));

        },
        backgroundColor: global.Global().primaryColor,
        tooltip: 'Add',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}
