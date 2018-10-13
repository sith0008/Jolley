import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './recipe_instructions.dart' as recipe_instructions;
import '../global.dart' as global;

class Recipe extends StatefulWidget {
  @override
  _RecipeState createState() => new _RecipeState();
}

class _RecipeState extends State<Recipe> {
  String barcode = "";
  String get qrBarcode {
    return barcode;
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return new Container(
        child: new Container(
            child: new GestureDetector(
      onTap: () {
        String recipeName = document['Name'];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    recipe_instructions.RecipeInstructions(recipeName)));
      },
      child: new Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        child: new ListTile(
            title: new Text(document['Name']),
            subtitle: new Text("Items: " + document['Items'])),
      ),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Recipes'),
        backgroundColor: global.Global().primaryColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: global.Global().textColor,
              displayColor: global.Global().textColor,
              fontFamily: 'Garamond',
            ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('Profiles')
                .document('Jay Sean')
                .collection('Recipe')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.only(top: 10.0),
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data.documents[index]),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scan();
        },
        backgroundColor: global.Global().primaryColor,
        tooltip: 'Add',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }

  addData() {
    DocumentReference documentReference = Firestore.instance
        .collection('Profiles')
        .document('Jay Sean')
        .collection('Recipe')
        .document(barcode);
    Map<String, String> listData = <String, String>{
      "Name": barcode,
      "Items": "5",
    };
    documentReference.setData(listData, merge: true).whenComplete(() {
      print("list created");
      //print(count.toString());
      //print(prevMessage);
    }).catchError((e) => print(e));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      print(barcode);
      addData();
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
