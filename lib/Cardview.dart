import 'package:flutter/material.dart';

import 'Writing/Writingapi.dart';


class CardViewWriting extends StatelessWidget {
  var data = getWriting();
  @override
  Widget build(BuildContext context) {
    return (
       Padding(padding: EdgeInsets.only(top: 15.0),
       
          child:  Card(
            elevation: 5.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.more),
                  title: Text(''),
                  subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
                ButtonTheme.bar( // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Icon(Icons.share),
                        onPressed: () {},
                      ),
                      FlatButton(
                        child: Icon(Icons.mode_edit),
                        onPressed: () { /* ... */ },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),));
         // card view 
       
    
  }
}