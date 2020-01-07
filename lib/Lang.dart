import 'dart:convert';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:toast/toast.dart';
import 'Auth/login.dart';




class LangPage extends StatefulWidget {
  @override
  _LangPageState createState() => _LangPageState();
}

class _LangPageState extends State<LangPage> {
 List<String> langs = [
    'Arabe',
    'English',
    'French',
    'Spanish',
    'Delhi',
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 130.0),),
              
              //Message welcome
            
             
              Padding(padding: EdgeInsets.only(top: 50.0),),


             Padding(padding: EdgeInsets.only(top: 20.0),),
             ButtonTheme(
                minWidth: 350.0,
                height: 60.0,
                child:  RaisedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  },   
                  color: Colors.blue,
                  child: Text('Next',style: TextStyle(color: Colors.white,fontSize: 25.0),),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                ),
              ),

             
            ],
          ),
        ),
      ),
    );
  }
}
