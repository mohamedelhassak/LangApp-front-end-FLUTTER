import 'package:flutter/material.dart';

import 'Writing.dart';


class DetailsWritingPage extends StatelessWidget {

  final Writing writing;
  DetailsWritingPage(this.writing);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: ListTile(
          title: Text(writing.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          subtitle: Text(writing.createdAt,style: TextStyle(color: Colors.white60),),
        ),
        
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text(writing.content,style: TextStyle(fontSize: 22.0,textBaseline: TextBaseline.ideographic),),
          ],
        )
      ),      
    );
  }
}