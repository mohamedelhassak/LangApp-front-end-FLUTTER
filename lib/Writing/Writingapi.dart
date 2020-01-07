import 'dart:convert';
import 'package:app_writing/Auth/Authapi.dart';
import 'package:app_writing/User/User.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Writing.dart';

Future<List<Writing>> getWriting() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  var lang = prefs.getString('secLang');
  print(lang);

  String url = serurl+"writings/"+lang;
 
  http.Response response = await http.get(url,headers: {
    'Accept' :'application/json',
    'Authorization' :'Bearer '+token,

  });
  var jsonData = jsonDecode(response.body);
  
List<Writing> writings = [];
for(var wr in jsonData){
  Writing writing = Writing(wr['title'], wr['content'], wr['created_at'], wr['user_id'],wr['user_name']);
  writings.add(writing);
}
print(writings.length);
return writings;
  
}

Future<List<User>> getUserById(id) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  String url = serurl+"user/"+id;
 
  http.Response response = await http.get(url,headers: {
    'Accept' :'application/json',
    'Authorization' :'Bearer '+token,

  });
  var jsonData = jsonDecode(response.body);
  
  List<User> users = [];
    User ur = User(jsonData[0]['name'], jsonData[0]['email']);
    users.add(ur);
  
print(users.length);
return users;
  
}
void postData() async{
  String url = serurl+"writing";

   http.post(url,headers: {
    'Accept' :'application/json',
    'content-type' :'application/json',
   
    'Authorization' :'Bearer '+getToken(), 

  }, body :json.encode({
    
      "title": "angulffhhhhgghgfar",
      "content": "errffffgghghghghghhgffffrrrrrrrrrrrrrrrrrr",
      "created_at": "2019-11-03 15:56:43",
      "user_id": 16
  })
  ).then((response){
    print(response.statusCode);
    print(response.body);
  });

}

void editData() async{
  String url = "http://192.168.1.101/writingApp/public/api/writing/4";

   http.put(url,headers: {
    'Accept' :'application/json',
    'content-type' :'application/json',
   
    'Authorization' :'Bearer '+getToken(),

  }, body :json.encode({
    
        "title": "c#ssxxxx",
        "content": "eeeeeeeeeeeeeeeeeggeeeeeeeeeeeeeeeeeeeeeeeee",
        "user_id": 3,
        "created_at": "2019-11-03 15:56:43",
        "updated_at": "2019-11-03 15:13:51"
  })
  ).then((response){
    print(response.statusCode);
    print(response.body);
  });

}