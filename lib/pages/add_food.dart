import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global.dart' as global;
import 'dart:async';

class AddFood extends StatefulWidget {
  final String foodType;
  AddFood(this.foodType);
  State createState() => new AddFoodState(foodType);
}

class AddFoodState extends State<AddFood> {
  final String foodType;
  AddFoodState(this.foodType);
  @override
  var count;
  var listCount;
  addItem(DocumentReference docRef) {
    
    docRef.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          count = int.parse(datasnapshot.data['quantity']) + 1;
          print (count);
        });
      }
    });
    return count;
  }
  countItems(DocumentReference docRef) {
    
    docRef.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          listCount = int.parse(datasnapshot.data['Items']);
          
        });
      }
    });
    return listCount;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(foodType),
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
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                  flex: 1)
                            ],
                          ))),
                      flex: 1),
                  new Expanded(
                      child: new StreamBuilder(
                          stream: Firestore.instance
                              .collection("Items")
                              .document(foodType)
                              .collection(foodType)
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
                                                          //var countItems;
                                                          DocumentReference docRef = Firestore
                                                              .instance
                                                              .collection(
                                                                  "Profiles")
                                                              .document(
                                                                  "Jay Sean")
                                                              .collection(
                                                                  "Personal")
                                                              .document(
                                                                  "Groceries List 1");
                                                              
                                                          countItems(docRef);

                                                          DocumentReference docRef2 = Firestore
                                                            .instance
                                                              .collection(
                                                                  "Profiles")
                                                              .document(
                                                                  "Jay Sean")
                                                              .collection(
                                                                  "Personal")
                                                              .document(
                                                                  "Groceries List 1")
                                                              .collection(
                                                                  "items")
                                                              .document("item"+(listCount+1).toString());
                                                              
                                                          //addItem(docRef2);
                                                          
                                                             
                                                            
                                                          docRef.setData({"Items":(listCount+1).toString()},merge:true);
                                                          docRef2.setData({
                                                            "checked": false,
                                                            "name": snapshot
                                                                    .data
                                                                    .documents[
                                                                index]['name'],
                                                            "barcode": snapshot
                                                                    .data
                                                                    .documents[
                                                                index]['Barcode'],
                                                            "image": snapshot
                                                                    .data
                                                                    .documents[
                                                                index]['image'],
                                                            "quantity": (quantity+1).toString()
                                                          },
                                                              merge: true)
                                                            .whenComplete(() {
                                                              print(
                                                                  "list created");
                                                              //print(count.toString());
                                                              //print(prevMessage);
                                                            }).catchError((e) =>
                                                                print(e));
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
                                                  child:  new Text(
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
                      flex: 6)
                ])));
  }
}
