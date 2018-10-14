import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import '../global.dart' as global;
import './home.dart';

<<<<<<< HEAD
=======

>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339
class GameGrid extends StatefulWidget {
  State createState() => new GameGridState();
}

class GameGridState extends State<GameGrid> {
<<<<<<< HEAD
  int points = 0;
=======
  int points=0;
>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339
  String barcode;
  Widget build(BuildContext context) {
    DocumentReference userPoints =
        Firestore.instance.document("Profiles/Jay Sean");
    userPoints.get().then((snapshot) {
      points = snapshot.data['points'];
    });
    //print(points);
    return new Scaffold(
      body: new Container(
        color: Color.fromRGBO(255, 204, 180, 1.0),
        // decoration: new BoxDecoration(
        //   gradient: new LinearGradient(
        //     begin: FractionalOffset.topCenter,
        //     end: FractionalOffset.bottomCenter,
        //     colors: [Colors.pink[200], Colors.grey[100]],
        //     //tileMode: TileMode.repeated
        //   ),
        // ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 30.0),
              child: new Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "My Shopping List",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "HomeSchool",
                    color: Colors.black,
                    fontSize: 35.0,
                  ),
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              /* decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Color.fromRGBO(245, 108, 87, 1.0), width: 1.0),
              ), */
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: new Text(
                            "1. Tap",
                            style: new TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontFamily: "JumpingFrogDemo",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        new ImageIcon(
                          AssetImage('assets/tap.png'),
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: new Text("2. Scan",
                              style: new TextStyle(
                                color: Colors.black,
                                fontFamily: "JumpingFrogDemo",
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
<<<<<<< HEAD
                        new ImageIcon(
                          AssetImage('assets/barcode.png'),
=======
                        new ImageIcon(AssetImage('assets/barcode.png'),
>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: new Text("3. Win",
                              style: new TextStyle(
                                color: Colors.black,
                                fontFamily: "JumpingFrogDemo",
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
<<<<<<< HEAD
                        new ImageIcon(
                          AssetImage('assets/trophy.png'),
=======
                        new ImageIcon(AssetImage('assets/trophy.png'),
>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            new Expanded(
                flex: 5,
                child: new StreamBuilder(
                    stream: Firestore.instance
                        .collection("Profiles")
                        .document("Jay Sean")
                        .collection("Personal")
                        .document("Family Party")
                        .collection("items")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Text("loading");
                      else
                        return new GridView.builder(
                          itemCount: snapshot.data.documents.length,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 0.0,
                                  crossAxisSpacing: 0.0,
                                  childAspectRatio: 1.0,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            // barcode_list[index] =
                            //     snapshot.data.documents[index]['barcode'];

                            if (snapshot.data.documents[index]["checked"] ==
                                true) {
                              return new Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  new GridTile(
                                    child: new Container(
<<<<<<< HEAD
                                      padding: EdgeInsets.all(7.0),
                                      child: new Card(
                                        elevation: 5.0,
                                        color: Colors.white,
                                        child: new Container(
                                          decoration: new BoxDecoration(
                                            border: new Border.all(
                                                color: Colors.white,
                                                width: 2.0),
                                          ),
                                          child: new Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              new Expanded(
                                                flex: 1,
                                                child: new Container(
                                                  color: Color.fromRGBO(
                                                      245, 108, 87, 1.0),
                                                  child: new Center(
                                                    child: new Text(
                                                      snapshot.data
                                                              .documents[index]
                                                          ['name'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "JumpingFrogDemo",
                                                          fontSize: 20.0,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              new Expanded(
                                                flex: 3,
                                                child: new Image.network(
                                                    snapshot.data
                                                            .documents[index]
                                                        ['image']),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // _buildGridTiles(
                                      //     context, snapshot.data.documents[index]);
                                    ),
                                  ),
=======
                                  padding: EdgeInsets.all(7.0),
                                  child: new Card(
                                    elevation: 5.0,
                                    color: Colors.white,
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                        border: new Border.all(
                                            color: Colors.white, width: 2.0),
                                      ),
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          new Expanded(
                                            flex: 1,
                                            child: new Container(
                                              color: Color.fromRGBO(
                                                  245, 108, 87, 1.0),
                                              child: new Center(
                                                child: new Text(
                                                  snapshot.data.documents[index]
                                                      ['name'],
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "JumpingFrogDemo",
                                                      fontSize: 20.0,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          new Expanded(
                                            flex: 3,
                                            child: new Image.network(snapshot
                                                .data
                                                .documents[index]['image']),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // _buildGridTiles(
                                  //     context, snapshot.data.documents[index]);
                                ),
                                  ),
>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339
                                  new Center(
                                      child: new CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 30.0,
                                    child:
                                        new Image.asset('assets/checked.png'),
                                  )),
                                ],
                              );
                            } else {
                              return new GestureDetector(
                                onTap: () {
                                  scan();
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        //print(barcode);
                                        //print(snapshot.data.documents[index]['barcode']);
                                        if (barcode ==
                                            snapshot.data.documents[index]
                                                ['barcode']) {
<<<<<<< HEAD
                                          String itemTrivia = snapshot.data.documents[index]['trivia'];
=======
>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339
                                          String number =
                                              (index + 1).toString();
                                          DocumentReference itemRef =
                                              Firestore.instance.document(
                                                  "Profiles/Jay Sean/Personal/Family Party/items/item" +
                                                      number);
                                          Map<String, bool> data =
                                              <String, bool>{
                                            "checked": true,
                                          };
                                          itemRef
                                              .setData(data, merge: true)
                                              .whenComplete(() {})
                                              .catchError((e) => print(e));

                                          points = points + 100;
<<<<<<< HEAD
                                          barcode = "";
=======
                                          barcode ="";
>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339

                                          return new Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 150.0,
                                                horizontal: 30.0),
                                            child: new Card(
                                              child: new Container(
                                                child: new Column(
<<<<<<< HEAD
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: <Widget>[
                                                    new Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.0),
                                                      color: Color.fromRGBO(
                                                          245, 108, 87, 1.0),
                                                      child: new Text(
                                                          "Congratulations!",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "JumpingFrogDemo",
=======
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: <Widget>[
                                                    new Container(
                                                      padding:EdgeInsets.symmetric(vertical: 10.0),
                                                      color: Color.fromRGBO(245, 108, 87, 1.0),
                                                      child: new Text(
                                                          "Congratulations!",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: "JumpingFrogDemo",
>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339
                                                            fontSize: 30.0,
                                                            color: Colors.white,
                                                          )),
                                                    ),
                                                    new Expanded(
<<<<<<< HEAD
                                                      flex: 3,
                                                      child: new Center(
                                                        child: new Text(
                                                            "You've found the right item and earned 100 points!",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "LettersforLearners",
                                                              fontSize: 30.0,
                                                              color:
                                                                  Colors.black,
                                                            )),
                                                      ),
                                                    ),
                                                    new Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: new Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10.0),
                                                        child: FlatButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop();
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return new Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            150.0,
                                                                        horizontal:
                                                                            30.0),
                                                                    child:
                                                                        new Card(
                                                                      child:
                                                                          new Container(
                                                                        child: new Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.stretch,
                                                                            children: <Widget>[
                                                                              new Container(
                                                                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                                                                color: Color.fromRGBO(245, 108, 87, 1.0),
                                                                                child: new Text(
                                                                                  "FUN FACT",
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(
                                                                                    fontFamily: "JumpingFrogDemo",
                                                                                    fontSize: 30.0,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              new Expanded(
                                                                                flex: 3,
                                                                                child: new Center(
                                                                                  child: new Text(itemTrivia,
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(
                                                                                        fontFamily: "LettersforLearners",
                                                                                        fontSize: 30.0,
                                                                                        color: Colors.black,
                                                                                      )),
                                                                                ),
                                                                              ),
                                                                              new Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: new Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10.0),
                                                        child: FlatButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop();
                                                          },
                                                          child: new Text(
                                                            "CONTINUE",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                new TextStyle(
                                                              fontFamily:
                                                                  "JumpingFrogDemo",
                                                              fontSize: 20.0,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      245,
                                                                      108,
                                                                      87,
                                                                      1.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                                            ]),
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          child: new Text(
                                                            "CONTINUE",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                new TextStyle(
                                                              fontFamily:
                                                                  "JumpingFrogDemo",
                                                              fontSize: 20.0,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      245,
                                                                      108,
                                                                      87,
                                                                      1.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
=======
                                                      flex:3,
                                                      child: new Center(
                                                        child: new Text(
                                                          "You've found the right item and earned 100 points!",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: "LettersforLearners",
                                                            fontSize: 30.0,
                                                            color: Colors.black,
                                                          )
                                                        ),
                                                      ),
                                                    ),
                                                    new Align(
                                                        alignment: Alignment.bottomCenter,
                                                        child: new Container(
                                                          padding: EdgeInsets.symmetric(vertical: 10.0),
                                                          child:FlatButton(
                                                            onPressed:(){
                                                              Navigator.of(context, rootNavigator: true).pop();
                                                            },
                                                            child: new Text("CONTINUE",
                                                              textAlign: TextAlign.center,
                                                              style:new TextStyle(
                                                                  fontFamily: "JumpingFrogDemo",
                                                                  fontSize: 20.0,
                                                                  color: Color.fromRGBO(245, 108, 87, 1.0),
                                                                ),),
                                                      ),),),
>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
<<<<<<< HEAD
                                        } else {
=======
                                        
                                        } 
                                        
                                        else {
>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339
                                          return new Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 150.0,
                                                horizontal: 30.0),
                                            child: new Card(
                                              child: new Container(
                                                child: new Column(
<<<<<<< HEAD
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: <Widget>[
                                                    new Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.0),
                                                      color: Color.fromRGBO(
                                                          245, 108, 87, 1.0),
                                                      child: new Text("OOPS!",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "JumpingFrogDemo",
=======
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: <Widget>[
                                                    new Container(
                                                      padding:EdgeInsets.symmetric(vertical: 10.0),
                                                      color: Color.fromRGBO(245, 108, 87, 1.0),
                                                      child: new Text(
                                                          "OOPS!",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: "JumpingFrogDemo",
>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339
                                                            fontSize: 30.0,
                                                            color: Colors.white,
                                                          )),
                                                    ),
                                                    new Expanded(
<<<<<<< HEAD
                                                      flex: 3,
                                                      child: new Center(
                                                        child: new Text(
                                                            "This isn't the right item! Try again!",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "LettersforLearners",
                                                              fontSize: 30.0,
                                                              color:
                                                                  Colors.black,
                                                            )),
                                                      ),
                                                    ),
                                                    new Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: new Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10.0),
                                                        child: FlatButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop();
                                                          },
                                                          child: new Text(
                                                            "CONTINUE",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                new TextStyle(
                                                              fontFamily:
                                                                  "JumpingFrogDemo",
                                                              fontSize: 20.0,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      245,
                                                                      108,
                                                                      87,
                                                                      1.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
=======
                                                      flex:3,
                                                      child: new Center(
                                                        child: new Text(
                                                          "This isn't the right item! Try again!",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: "LettersforLearners",
                                                            fontSize: 30.0,
                                                            color: Colors.black,
                                                          )
                                                        ),
                                                      ),
                                                    ),
                                                     new Align(
                                                        alignment: Alignment.bottomCenter,
                                                        child: new Container(
                                                          padding: EdgeInsets.symmetric(vertical: 10.0),
                                                          child:FlatButton(
                                                            onPressed:(){
                                                              Navigator.of(context, rootNavigator: true).pop();
                                                            },
                                                            child: new Text("CONTINUE",
                                                              textAlign: TextAlign.center,
                                                              style:new TextStyle(
                                                                  fontFamily: "JumpingFrogDemo",
                                                                  fontSize: 20.0,
                                                                  color: Color.fromRGBO(245, 108, 87, 1.0),
                                                                ),),
                                                      ),),),
                                                    
>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      });
                                },
                                child: new Container(
                                  padding: EdgeInsets.all(7.0),
                                  child: new Card(
                                    elevation: 5.0,
                                    color: Colors.white,
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                        border: new Border.all(
                                            color: Colors.white, width: 2.0),
                                      ),
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          new Expanded(
                                            flex: 1,
                                            child: new Container(
                                              color: Color.fromRGBO(
                                                  245, 108, 87, 1.0),
                                              child: new Center(
                                                child: new Text(
                                                  snapshot.data.documents[index]
                                                      ['name'],
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "JumpingFrogDemo",
                                                      fontSize: 20.0,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          new Expanded(
                                            flex: 3,
                                            child: new Image.network(snapshot
                                                .data
                                                .documents[index]['image']),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // _buildGridTiles(
                                  //     context, snapshot.data.documents[index]);
                                ),
                              );
                            }
                          },
                        );
                    })),
            new Expanded(
              flex: 1,
              child: new Row(
                children: <Widget>[
                  new Expanded(
<<<<<<< HEAD
                    flex: 3,
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: new Container(
                        margin: EdgeInsets.fromLTRB(3.0, 10.0, 3.0, 10.0),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: new BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                        child: Center(
                          child: Text(
                            "EXIT",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: "AldotheApache"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Expanded(
                    flex: 5,
                    child: new Container(
                      margin: EdgeInsets.fromLTRB(3.0, 10.0, 3.0, 10.0),
                      decoration: new BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.white, width: 1.0),
                      ),
                      child: Center(
                        child: Text(
                          points.toString() + " POINTS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: "AldotheApache"),
                        ),
                      ),
                    ),
                  ),
                  new Expanded(
                    flex: 3,
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: new Container(
                        margin: EdgeInsets.fromLTRB(3.0, 10.0, 3.0, 10.0),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: new BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                        child: Center(
                          child: Text(
                            "SUBMIT",
=======
                    flex:3,
                    child: new GestureDetector(
                      onTap:(){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home()));
                          },
                      child: new Container(
                        margin: EdgeInsets.fromLTRB(3.0, 10.0, 3.0, 10.0),
                        padding: EdgeInsets.symmetric(horizontal:10.0),
                        decoration: new BoxDecoration(
                          color: Colors.amber,
                          shape:  BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.white, width: 1.0),
                          ),
                        child: Center(
                          child: Text("EXIT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily:"AldotheApache"),),),
                    ),
                  ),
                  ),

                  new Expanded(
                    flex:5,
                    child: new Container(
                    margin: EdgeInsets.fromLTRB(3.0, 10.0, 3.0, 10.0),
                    decoration: new BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.white, width: 1.0),
                    ),
                      child: Center(
                        child: Text(points.toString() + " POINTS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "AldotheApache"),),),
                  ),),
                  new Expanded(
                    flex: 3,
                    child: new GestureDetector(
                      onTap:(){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home()));
                          },
                      child: new Container(
                    margin: EdgeInsets.fromLTRB(3.0, 10.0, 3.0, 10.0),
                    padding: EdgeInsets.symmetric(horizontal:10.0),
                    decoration: new BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.white, width: 1.0),
                      ),
                      child: Center(
                        child: Text("SUBMIT",
>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
<<<<<<< HEAD
                                fontFamily: "AldotheApache"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
=======
                                fontFamily: "AldotheApache"),),),
                    ),
                  ),),
                ],
              ),


              
>>>>>>> fcf9ba2a2b22e1255283b726ba5efe88f7d7c339
            ),
          ],
        ),
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
