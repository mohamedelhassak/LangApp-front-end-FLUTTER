import 'dart:convert';

import 'package:app_writing/Home.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'Register.dart';
import 'Authapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final email = TextEditingController();
  final pass = TextEditingController();
  bool _validare(){
    if(email.text.isEmpty || pass.text.isEmpty ) 
      return false;
    else return true;
  }
void showMess(String msg){
   Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

 

  
  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            child: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 130.0),),
              Icon(Icons.person,color: Colors.blue,size: 100.0,),
             
              Padding(padding: EdgeInsets.only(top: 20.0),),

              SizedBox(
                child: TextField( 
                  controller: email,
                  decoration: InputDecoration(
                  
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  )
                  ),
                ),
              width: 350.0,
              ),

      

              Padding(padding: EdgeInsets.only(top: 30.0),),

              SizedBox(
                child: TextField(
                  controller: pass,
                  decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )
                  ),
              ),
              width: 350.0,
              ),


              Padding(padding: EdgeInsets.only(top: 30.0),),

              
             ButtonTheme(
                minWidth: 350.0,
                height: 60.0,
                child:  RaisedButton(
                  onPressed: () async {
                    final userdata = {
                      'email':email.text,
                      'password':pass.text,
                    };
                    if(_validare() == true){

                      String url = serurl+"login";

                      final res = await http.post(url,headers: {
                        'content-type' :'application/json',
                      
                      }, body :json.encode(userdata)
                      );

                      var data  = json.decode(res.body);
                      var status = res.statusCode;
                       
                      print(status);
                      if(status == 200){
                        getToken();
                        logout();
                        setToken(data['token']);
                        setName(data['user']['name']);
                        setEmail(data['user']['email']);
                        setNativeLang(data['user']['native_lang']);
                        setSecLang(data['user']['other_lang']);

                         showMess("Welcome "+data['user']['name']);

                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                      }else if(status == 401){
                        showMess("Password or Email invalid ...");
                      }else{
                        showMess("Sothing wrong ...Try Again");
                      }
                      
                    }
                    else{
                      print("Email amd Password Cannot be empty ");
                      showMess("Email amd Password Cannot be empty ");
                    }
                   
                   
                  },   
                  color: Colors.blue,
                  child: Text('Log in',style: TextStyle(color: Colors.white,fontSize: 25.0),),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 30.0),),

             InkWell(
               onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
               },
               child: Center(child: Text('Create an account ',style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 15.0),),),
             )

            
             
            ],
          ),
          )
        ),
      ),
    );
  }
}
