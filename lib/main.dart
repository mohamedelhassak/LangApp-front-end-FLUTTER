import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth/login.dart';
import 'Home.dart';


Future main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  print(token);

 runApp(
   MaterialApp(home: token == null ?LoginPage() : HomePage())
 );
}






