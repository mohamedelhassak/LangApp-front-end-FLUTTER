import 'dart:convert';

import 'package:app_writing/Auth/Authapi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class AddWiting extends StatefulWidget {
  @override
  _AddWitingState createState() => _AddWitingState();
}

class _AddWitingState extends State<AddWiting> {
  void showMess(String msg){
   Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
  final title = TextEditingController();
  final content = TextEditingController();

//   Future<String> getToken() async {
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//   return  prefs.getString('token')?? 0;
// }


// setTokenData(){
//   getToken().then((onValue){
//     setState((){
//       token = onValue;
//     });
//   });}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Add New Writing"),
        actions: <Widget>[
          
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new TextField(
              controller: title,
              decoration: new InputDecoration(
                hintText: "Title",
              ),
            ),
          ),
          new ListTile(
            title:  new TextField(
              controller: content,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Content",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                  ),
                keyboardType: TextInputType.multiline,
            )
          ),

          ListTile(
            title:  new RaisedButton(
                child: Text("Add"),
                color: Colors.blue,
                textTheme: ButtonTextTheme.primary,
                onPressed: () async {print(this.content.text);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var token = prefs.getString('token');
                var lang = prefs.getString('secLang');
                var user = prefs.getString('name');
                String url = serurl+"writing";
                   http.post(url,headers: {
                    'Accept' :'application/json',
                    'content-type' :'application/json',
                  
                    'Authorization' :'Bearer '+token, 

                  }, body :json.encode({
                    
                      "title": this.title.text,
                      "content": this.content.text,
                      "lang": lang ,
                      "user_name": user,
                  })
                  ).then((response){
                    print(response.statusCode);
                    if(response.statusCode == 200){
                      showMess("Writing added successfuly. ..");
                    }else{
                      showMess("Something wrong try again...");
                    }
                    print(response.body);
                    print(user);
                    print(lang);
                  });
                },
            )
          ),
          
        ],
      ),
    );
  }
}