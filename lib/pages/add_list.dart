import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './add_food.dart' as add_food;
import '../global.dart' as global;

class AddList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Shop Catalogue'),
          backgroundColor: global.Global().primaryColor,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: global.Global().textColor,
                displayColor: global.Global().textColor,
                fontFamily: 'Garamond',
              ),
        ),
        body: new Container(
          color: Colors.grey[200],
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
                            child: new GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              add_food.AddFood(foodType)));
                                },
                                child: GridTile(
                                    footer: new Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(foodType,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13.0))),
                                    child: new Container(
                                      margin: const EdgeInsets.all(40.0),
                                      child: new Image.network(snapshot
                                          .data.documents[index]['image']),
                                    ))));
                      });
              }),
        ));
  }
}
