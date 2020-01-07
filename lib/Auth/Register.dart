import 'dart:convert';
import 'dart:core' as prefix0;
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'Authapi.dart';
import 'login.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

   TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();

  var  langs = ["English","French","Arab","Spanish"];  
  var _secLang = "English";
  var _nativeLang = "English";
   bool _validare(){
    if(email.text.isEmpty || pass.text.isEmpty || name.text.isEmpty  ) 
      return false;
    else return true;
  }

  void showMess(String msg){
   Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0,right: 20.0),
            child: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 50.0),),
              Icon(Icons.person,color: Colors.blue,size: 100.0,),
              SizedBox(
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)
                  )
                  ),
              ),
              width: 350.0,
              ),

              Padding(padding: EdgeInsets.only(top: 20.0),),

              SizedBox(
                child: TextField( 
                  controller: email,
                  decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)
                  )
                  ),
              ),
              width: 350.0,
              ),

              Padding(padding: EdgeInsets.only(top: 20.0),),

              SizedBox(
                child: TextField( 
                  controller: pass,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)
                    )
                  ),
              ),
              width: 350.0,
              ),
             // Combobox native lang
              Padding(padding: EdgeInsets.only(top: 20.0),),
              Center(child: Text("Chose your native lamguge"),),
              SizedBox(
                child:Padding(
                  padding: EdgeInsets.only(left: 100.0,right: 90),
                  child: DropdownButton<String>(
                    value: _nativeLang,
                    items: langs.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                        setState(() {
                      _nativeLang = newValue;
                      prefix0.print(_nativeLang);
                    });
                    },
                ),
                ),
              width: 350.0,
              ),


              // Combobox sec lang
              Padding(padding: EdgeInsets.only(top: 20.0),),
              Center(child: Text("Chose your second lamguge"),),
              SizedBox(
                child:Padding(
                  padding: EdgeInsets.only(left: 100.0,right: 90),
                  child: DropdownButton<String>(
                    value: _secLang,
                    items: langs.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                        setState(() {
                      _secLang = newValue;
                      prefix0.print(_secLang);
                    });
                    },
                ),
                ),
              width: 350.0,
              ),


              Padding(padding: EdgeInsets.only(top: 20.0),),

             ButtonTheme(
                minWidth: 350.0,
                height: 60.0,
                child:  RaisedButton(
                  onPressed: () async {
                     final userdata = {
                      'email':email.text,
                      'password':pass.text,
                      'name':name.text,
                      "native_lang": _nativeLang.toLowerCase(),
                      "other_lang": _secLang.toLowerCase(),
                    };
                    if(_validare() == true){

                      String url = serurl+"register";
                      // check if email already exist
                       http.post(serurl+"checkEmail",headers: {
                      },body: {
                        'email':email.text,
                      }).then((response){
                        var emailStatus = response.statusCode;
                        prefix0.print(emailStatus);
                        if (emailStatus == 200) {
                          showMess("This email already used ..please try another one");
                        }
                        else if(emailStatus == 404){
                         //Register new user
                           http.post(url,headers: {
                        'content-type' :'application/json',
                    
                        }, body :json.encode(userdata)
                        ).then((response){
                          print(response.statusCode);
                          print(response.body);
                        
                          var status = response.statusCode;
                        
                          if(status == 200){
                            showMess('Account Created ...');
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()));
                          }else if (status==400) {
                            showMess("please enter valid information");
                          }
                          else{
                            showMess("something wrong ...try again");
                          }
                        
                          
                        });
                        }
                      });

                     
                      }
                      else{
                        print("Email amd Password Cannot be empty ");
                        showMess("Email amd Password and name Cannot be empty ");
                      }
                    
                    },
                  
                  color: Colors.blue,
                  child: Text('Register',style: TextStyle(color: Colors.white,fontSize: 25.0),),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 15.0),),

             InkWell(
               onTap: (){ Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );},
               child: Center(child: Text('Alredy have an account',style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 15.0),),),
             )

            
             
            ],
          ),
          )
        ),
      ),
    );
  }

  
}








   