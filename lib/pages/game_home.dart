import 'package:flutter/material.dart';
import './game_grid.dart';

class GameHome extends StatefulWidget {
  State createState() => new GameHomeState();
}

class GameHomeState extends State<GameHome> {
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        width: double.infinity,
        height: double.infinity,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [Colors.pink[300], Colors.orange[100]],
            //tileMode: TileMode.mirror
          ),
        ),
        child: new Padding(
          padding: EdgeInsets.fromLTRB(30.0, 150.0, 30.0, 150.0),
          child: new Container(
            child: new Column(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(top: 50.0),
                  child: new Text("Ready for some family fun?",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontFamily: "ObelixPro", fontSize: 30.0)),
                ),
                new Container(
                  padding: EdgeInsets.only(top: 50.0),
                  child: new Container(
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(32.0),
                      color: Colors.white,
                    ),
                    child: new RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameGrid(),
                          ),
                        );
                      },
                      elevation: 2.0,
                      color: Color.fromRGBO(100, 155, 255, 1.0),
                      splashColor: Color.fromRGBO(0, 100, 255, 1.0),
                      child: new Text("Next",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Raleway",
                              fontSize: 20.0)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
