
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


String serurl ="http://192.168.1.157:8080/writingApp/public/api/";
var status;



  getToken() async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.getString('token') ?? 0;
        
    }

     claerToken() async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.remove('token');
        
    }

    getName() async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.getString('name') ;
      return token;
        
    }

     getEmail() async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.get('getString') ;
      return token;
        
    }

    setToken(String tokenVal) async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.setString('token', tokenVal);  
    }

    setName(String name) async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.setString('name', name);  
    }

    setEmail(String name) async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.setString('email', name);  
    }

     setNativeLang(String name) async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.setString('nativeLang', name);  
    }


 setSecLang(String name) async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.setString('secLang', name);  
    }


     


void logout() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.remove('token');
     print(token);
        
}