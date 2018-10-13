import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global.dart' as global;

class AddRecipe extends StatelessWidget {
  final String recipeType;
  AddRecipe(this.recipeType);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(recipeType),
          backgroundColor: global.Global().primaryColor,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: global.Global().textColor,
                displayColor: global.Global().textColor,
                fontFamily: 'Garamond',
              ),
        ),
        body: new Container(
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
                                          child: new Text('Add to Cart',
                                              style: new TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontSize: 20.0,
                                                  fontWeight:
                                                      FontWeight.bold)))),
                                  flex: 4),
                              new Expanded(
                                  child: new IconButton(
                                      icon: new Icon(Icons.add_shopping_cart),
                                      onPressed: () {}),
                                  flex: 1)
                            ],
                          ))),
                      flex: 1),
                  new Expanded(
                      child: new StreamBuilder(
                          stream: Firestore.instance
                              .collection('Profiles')
                              .document('Jay Sean')
                              .collection('Recipe')
                              .document('Curry Chicken')
                              .collection('items')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
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
                                    int quantity = snapshot
                                        .data.documents[index]['quantity'];
                                    String strQuantity = quantity.toString();
                                    return new Card(
                                        child: new GridTile(
                                            footer: new Padding(
                                                padding: EdgeInsets.all(1.0),
                                                child: new Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      new IconButton(
                                                        icon:
                                                            Icon(Icons.remove),
                                                        tooltip:
                                                            'Decrease quantity by 1',
                                                        onPressed: () {
                                                          Firestore.instance
                                                              .runTransaction(
                                                                  (Transaction
                                                                      transaction) async {
                                                            DocumentSnapshot
                                                                snapshot2 =
                                                                await transaction
                                                                    .get(snapshot
                                                                        .data
                                                                        .documents[
                                                                            index]
                                                                        .reference);
                                                            await transaction
                                                                .update(
                                                                    snapshot2
                                                                        .reference,
                                                                    {
                                                                  'quantity':
                                                                      snapshot2[
                                                                              'quantity'] -
                                                                          1
                                                                });
                                                          });
                                                        },
                                                      ),
                                                      new Text(
                                                        strQuantity,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      new IconButton(
                                                        icon: Icon(Icons.add),
                                                        tooltip:
                                                            'Increase quantity by 1',
                                                        onPressed: () {
                                                          Firestore.instance
                                                              .runTransaction(
                                                                  (Transaction
                                                                      transaction) async {
                                                            DocumentSnapshot
                                                                snapshot2 =
                                                                await transaction
                                                                    .get(snapshot
                                                                        .data
                                                                        .documents[
                                                                            index]
                                                                        .reference);
                                                            await transaction
                                                                .update(
                                                                    snapshot2
                                                                        .reference,
                                                                    {
                                                                  'quantity':
                                                                      snapshot2[
                                                                              'quantity'] +
                                                                          1
                                                                });
                                                          });
                                                        },
                                                      ),
                                                    ])),
                                            child:
                                                new Column(children: <Widget>[
                                              new Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        40.0, 20.0, 40.0, 0.0),
                                                child: new Image.network(
                                                    snapshot.data
                                                            .documents[index]
                                                        ['image']),
                                              ),
                                              new Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: new Text(
                                                      snapshot.data
                                                              .documents[index]
                                                          ['name'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13.0))),
                                            ])));
                                  });
                          }),
                      flex: 5)
                ])));
  }
}
