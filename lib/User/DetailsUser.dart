import 'package:flutter/material.dart';

import 'User.dart';

class DetailsUserPage extends StatelessWidget {
  final User user;
  DetailsUserPage(this.user);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(user.name),
      ), 
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           ListTile(
             leading: CircleAvatar(
               child: Text("data"),
             ),
             title:Text(user.name) ,
             subtitle: Text(user.name),
           )
            
          ],
        ),
      ),     
    );
  }
  }
