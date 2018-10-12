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
        color: Color.fromRGBO(255, 204, 172, 1.0),
        /* decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [Colors.pink[300], Colors.orange[100]],
            //tileMode: TileMode.mirror
          ),
        ), */
        child: new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: new Container(
            child: new Column(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.symmetric(vertical:40.0),
                  child: new Text(
                    "Time for some family fun!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "LettersforLearners",
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Expanded(
                  child: new Container(
                    
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.all(10.0),
                          child: new Row(
                            children: <Widget>[
                              new CircleAvatar(
                                radius: 42.0,
                                backgroundColor: Colors.teal[300],
                                child: Image.asset("assets/tap.png"),
                              ),
                              new Expanded(child:new Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: new Text(
                                    "Tap on a food item!",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "LettersforLearners",
                                      fontSize: 30.0,
                                    ),
                                  ),),),
                            ],
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.all(10.0),
                          child: new Row(
                            children: <Widget>[
                              new CircleAvatar(
                                radius: 42.0,
                                backgroundColor: Colors.blue,
                                child: Image.asset("assets/barcode.png"),
                              ),
                              new Expanded(child:new Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: new Text(
                                    "Find item and scan its barcode!",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "LettersforLearners",
                                      fontSize: 30.0,
                                    ),
                                  ),),),
                            ],
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.all(10.0),
                          child: new Row(
                            children: <Widget>[
                              new CircleAvatar(
                                radius: 42.0,
                                backgroundColor: Colors.lime,
                                child: Image.asset("assets/trophy.png"),
                              ),
                              new Expanded(child:new Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: new Text(
                                    "Earn points and win!",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "LettersforLearners",
                                      fontSize: 30.0,
                                    ),
                                  ),),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new GestureDetector(
                      onTap:(){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GameGrid()));
                          },
                      child: new Container(
                        margin: EdgeInsets.fromLTRB(3.0, 10.0, 3.0, 10.0),
                        padding: EdgeInsets.symmetric(horizontal:10.0,vertical:10.0,),
                        decoration: new BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.white, width: 1.0),
                          ),
                        child: Center(
                          child: Text("CONTINUE",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: "AldotheApache"),),),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
