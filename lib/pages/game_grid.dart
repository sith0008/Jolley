import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class GameGrid extends StatefulWidget {
  State createState() => new GameGridState();
}

class GameGridState extends State<GameGrid> {

  int points;
  List barcode_list;
  String barcode;
  Widget build(BuildContext context) {
    DocumentReference userPoints = Firestore.instance.document("Profiles/Jay Sean");
    userPoints.get().then((snapshot){
      points = snapshot.data['points'];
    });
    return new Scaffold(
      body: new Container(
        color: Colors.red,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 30.0),
              child: new Text(
                "Your Shopping List",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
            new Container(
              padding: EdgeInsets.only(top: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: new Text("1. Tap",
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              )),
                        ),
                        new Icon(
                          Icons.touch_app,
                          color: Colors.white,
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
                                color: Colors.white,
                                fontSize: 20.0,
                              )),
                        ),
                        new Icon(
                          Icons.camera_alt,
                          color: Colors.white,
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
                                color: Colors.white,
                                fontSize: 20.0,
                              )),
                        ),
                        new Icon(
                          Icons.score,
                          color: Colors.white,
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
                        .document("List1")
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
                                true)  {
                              return  new Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  new GridTile(
                                    child: new Container(
                                      padding: EdgeInsets.all(7.0),
                                      child: new Card(
                                        elevation: 5.0,
                                        color: Colors.white,
                                        child: new Column(
                                          children: <Widget>[
                                            new Expanded(
                                              flex: 3,
                                              child: new Image.network(snapshot
                                                  .data
                                                  .documents[index]['image']),
                                            ),
                                            new Expanded(
                                              flex: 1,
                                              child: new Container(
                                                child: new Text(snapshot.data
                                                    .documents[index]['name']),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // _buildGridTiles(
                                      //     context, snapshot.data.documents[index]);
                                    ),
                                  ),
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
                                          String number =
                                              (index + 1).toString();
                                          DocumentReference itemRef =
                                              Firestore.instance.document(
                                                  "Profiles/Jay Sean/Personal/List1/items/item" +
                                                      number);
                                          Map<String, bool> data =
                                              <String, bool>{
                                            "checked": true,
                                          };
                                          itemRef
                                              .setData(data, merge: true)
                                              .whenComplete(() {})
                                              .catchError((e) => print(e));
                                          
                                            points  = points + 100;

                                          return new Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 150.0,
                                                horizontal: 30.0),
                                            child: new Card(
                                              child: Center(
                                                child: new Text(
                                                    "Congratulations, you found the right item! You scored 100 points!"),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return new Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 150.0,
                                                horizontal: 30.0),
                                            child: new Card(
                                              child: Center(
                                                child: new Text(
                                                    "This is not the right item!"),
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
                                    child: new Column(
                                      children: <Widget>[
                                        new Expanded(
                                          flex: 3,
                                          child: new Image.network(snapshot
                                              .data.documents[index]['image']),
                                        ),
                                        new Expanded(
                                          flex: 1,
                                          child: new Container(
                                            child: new Text(snapshot
                                                .data.documents[index]['name']),
                                          ),
                                        ),
                                      ],
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
              child: new Card(
                  child: Text(points.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30.0))),
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
