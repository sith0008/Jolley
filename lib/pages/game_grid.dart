import 'package:flutter/material.dart';
import './scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameGrid extends StatefulWidget {
  State createState() => new GameGridState();
}

class GameGridState extends State<GameGrid> {
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.red,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
                flex: 5,
                child: new StreamBuilder(
                    stream: Firestore.instance
                        .collection("Profiles")
                        .document("Jay Sean")
                        .collection("Personal")
                        .document("List1")
                        .collection("items")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Text("loading");
                      return new GridView.builder(
                        itemCount: snapshot.data.documents.length,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          _buildGridTiles(
                              context, snapshot.data.documents[index]);
                        },
                      );
                    })),
            new Expanded(
              flex: 1,
              child: new Container(
                color: Colors.pink[100],
                child: Text("test"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildGridTiles(BuildContext context, DocumentSnapshot document) {
    return new GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scanner(),
            ),
          );
        },
        child: Card(
            color: Colors.white,
            child: new GridTile(
              child: new Text("test"),
              footer: Text(document['name']),
            )));
  }
}
