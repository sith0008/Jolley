import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFood extends StatelessWidget {
  final String foodType;
  double _sliderValue = 1.0;
  AddFood(this.foodType);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(foodType),
        ),
        body: new Container(
            color: Colors.red,
            child: new StreamBuilder(
                stream: Firestore.instance
                    .collection("Items")
                    .document(foodType)
                    .collection(foodType)
                    .snapshots(),
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
                          return new Card(
                              child: new GridTile(
                                  footer: new RaisedButton(
                                    child: new Text(
                                      '123',
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(context: context,
                                      builder: (context){
                                        return new Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Column(
                                              children: <Widget>[
                                                new Container(
                                                  padding: new EdgeInsets.symmetric(
                                                    vertical: 16.0,
                                                    horizontal: 16.0,
                                                  ),
                                                  child: new Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      // new Slider(
                                                      //   activeColor: Colors.indigoAccent,
                                                      //   min: 0.0,
                                                      //   max: 10.0,
                                                      //   divisions: 1,
                                                      //   value: _sliderValue,
                                                      //   onChanged: (double newValue){
                                                      //     setState((){
                                                      //       _sliderValue = newValue;
                                                      //     });
                                                      //   },
                                                      // ),
                                                      new Container(
                                                        width: 50.0,
                                                        alignment: Alignment.center,
                                                        child: new Text('Quantity',)
                                                        // child: new Text('${_sliderValue.toInt()}',
                                                        //     style: Theme.of(context).textTheme.display1),
                                                      ),
                                                    ]
                                                  )
                                                ),
                                                new RaisedButton(
                                                  onPressed: () => print('pressed!'),
                                                  child: new Text('Submit'),
                                                  color: Colors.indigoAccent,
                                                )
                                              ],
                                            ),
                                          ]
                                        );
                                      })
                                      ;
                                    },
                                  ),
                                  child: new Container(
                                    margin: const EdgeInsets.all(40.0),
                                    child: new Image.network(snapshot
                                        .data.documents[index]['image']),
                                  )));
                        });
                })));
  }
}
