import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe extends StatelessWidget {
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return new Container(
      child: new Container(
        child: new Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: new ListTile(
              title: new Text(document['Name']),
              subtitle: new Text("Items: " + document['Items']),),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.grey[200],
        child: new StreamBuilder(
            stream: Firestore.instance
                .collection('Profiles')
                .document('Jay Sean')
                .collection('Recipes')
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
