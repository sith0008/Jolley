import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './add_food.dart' as add_food;

class AddList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add"),
        ),
        body: new Container(
          color: Colors.red,
          child: new StreamBuilder(
              stream: Firestore.instance.collection("Items").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Text("loading");
                else
                  return new GridView.builder(
                      itemCount: snapshot.data.documents.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 0.0,
                              childAspectRatio: 1.0,
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        String foodType =
                            snapshot.data.documents[index]['name'];
                        return new Card(
                            child: new GridTile(
                                footer: new RaisedButton(
                                  child: new Text(
                                    foodType,
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            add_food.AddFood(foodType),
                                      ),
                                    );
                                  },
                                ),
                                child: new Container(
                                  margin: const EdgeInsets.all(40.0),
                                  child: new Image.network(
                                      snapshot.data.documents[index]['image']),
                                )));
                      });
              }),
        ));
  }
}
