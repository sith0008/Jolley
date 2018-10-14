import 'package:flutter/material.dart';
import './list.dart' as list;
import './recipe.dart' as recipe;

class ParentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.grey[200],
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Expanded(
                  child: new Container(
                      child: new GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => list.List()));
                          },
                          child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              margin:
                                  EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 20.0),
                              child: new Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 10.0),
                                  child: new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Center(
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 52.0,
                                            child:
                                                Image.asset('assets/list.png'),
                                          ),
                                        ),
                                        new Center(
                                            child: new Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: new Text(
                                                  'Grocery Lists',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )))
                                      ]))))),
                  flex: 1),
              new Expanded(
                  child: new Container(
                      child: new GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => recipe.Recipe()));
                          },
                          child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              margin:
                                  EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 40.0),
                              child: new Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 10.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Center(
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 52.0,
                                            child: Image.asset(
                                                'assets/recipe.png'),
                                          ),
                                        ),
                                        new Center(
                                            child: new Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: new Text(
                                                  'Recipes',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )))
                                      ]))))),
                  flex: 1)
            ]));
  }
}
