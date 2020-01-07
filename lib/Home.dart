


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Auth/Authapi.dart';
import 'Auth/login.dart';
import 'User/DetailsUser.dart';
import 'Writing/DetailsWriting.dart';
import 'Writing/Writingapi.dart';
import 'Writing/addWriting.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var name =""; 
  var email ="";
  var secLang = "";



  @override
  Future initState()  {
    setUserData();
    
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirmation"),
          content: new Text("Are sureyou want to disconnect ?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
             
            FlatButton(
              child: Text('Cancel'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              
              child:  Text("Yes"),
              onPressed: () {
               logout();
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
              },
              
            ),

          ],
        );
      },
    );
  }
  
Future<String> getUserName() async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString('name')?? 0;
}

Future<String> getUserEmail() async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString('email')?? 0;
}

Future<String> getUserSecLang() async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString('secLang')?? 0;
}

setUserData(){
  getUserName().then((onValue){
    setState((){
      name = onValue;
    });
  });

  getUserEmail().then((onValue){
    setState((){
      email = onValue;
    });
  });

   getUserSecLang().then((onValue){
    setState((){
      secLang = onValue;
    });
  });

  
}
  
  @override
  Widget build(BuildContext context) {
   
    // Carsoul images widget
 

    return Scaffold(
        // Top bar widget
      appBar:  AppBar(
        backgroundColor: Colors.blue,
        title: Text('Home'),
        actions: <Widget>[
          
  
          Padding(
            padding: EdgeInsets.only(right: 80.0),
            child: Center(
              child: Text(secLang),
            ),
          ),
               
          IconButton(icon: Icon(Icons.search,color: Colors.white,),onPressed: null,),
          IconButton(icon: Icon(Icons.sort,color: Colors.white,),onPressed: null,),
          
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(


        
        child: FutureBuilder(
          future: getWriting(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if (snapshot.data==null) {
              return Container(child: 
              Center(
                child: Text('loading...'),
              ),);
            }else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context ,int index){
                return Padding(
                  padding: EdgeInsets.only(top: 30.0,bottom: 10.0,left: 0.0,right: 0.0),
                  child: Column(
                    children: <Widget>[
                      
                      Container(
                        color: Colors.white,
                        
                        child: Column(
                          children: <Widget>[
                                        // header user info et 
                            Wrap(
                              spacing: 8.0, // gap between adja cent chips
                              runSpacing: 4.0,
                              direction: Axis.horizontal,
                              children: <Widget>[
                              InkWell(
                                onTap: (){
                                  
                                  
                                },
                                child:  Container(
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Icon(Icons.person,size: 40.0,color: Colors.grey,),
                                      ),
                                      SizedBox(
                                        child:FutureBuilder(
                                          future: getUserById(snapshot.data[index].userIid.toString()),
                                          builder: (BuildContext context,AsyncSnapshot snapshot){
                                            if (snapshot.data==null) {
                                              return Container(child: 
                                              Center(
                                                child: Text('user...'),
                                              ),);
                                            }else{
                                              
                                                 return InkWell(
                                                   onTap: (){
                                                     print('object');
                                                      Navigator.push(context, 
                                                      MaterialPageRoute(
                                                        builder: (context)=> DetailsUserPage(snapshot.data[0])
                                                      ));
                                                   },
                                                   child: Padding(
                                                   padding: EdgeInsets.only(left: 20.0),
                                                   child: Column(
                                                     children: <Widget>[
         
                                                       Text(snapshot.data[0].name,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18.0),),
                                                       Text(snapshot.data[0].email,),
                                                     ],
                                                   )
                                                 ),

                                                 );
                                              
                                            }
                                          }
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  print('icon');
                                },
                                child:  SizedBox(
                                  child: Padding(padding: EdgeInsets.only(left: 380),child: Icon(Icons.more_horiz)),)
                                ,
                              )
                              ],
                            ),

                          SizedBox(
                            width: 300.0,
                            child:  Divider(
                              height: 5.0,
                              color: Colors.grey,
                            ),
                          ),

                            //body row

                            Wrap(
                              children: <Widget>[
                          
                              InkWell(
                                onTap: (){
                                  print("object");
                                  Navigator.push(context, 
                                  MaterialPageRoute(
                                    builder: (context)=> DetailsWritingPage(snapshot.data[index])
                                  ));
                                },
                                child:  SizedBox(
                                  width: 380.0,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10.0,top: 5.0),
                                        child: Text(snapshot.data[index].title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17.0,),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0,right: 10.0),
                                        child: ListTile(
                                          title: Text(snapshot.data[index].content),
                                          subtitle: Padding(
                                            child: Text(snapshot.data[index].createdAt),
                                            padding: const EdgeInsets.only(top: 20.0),
                                          )
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              )
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child:  Divider(
                                thickness: 1.5,
                              ),
                            ),
                            //row footer
                            Wrap(
                              children: <Widget>[
                                ButtonTheme.bar(
                                  child: ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                      child: const Icon(Icons.insert_comment,color: Colors.blue,),
                                      onPressed: () { /* ... */ },
                                    ),
                                    FlatButton(
                                      child: const Icon(Icons.share,color: Colors.blue,),
                                      onPressed: () { /* ... */ },
                                    ),
                                  ],
                                ),
                                )
                              ],
                            )
                        
                          ],
                        ),
                      ),
                    Divider(
                      color: Colors.grey[300],
                      height: 10.0,
                      endIndent: 0.0,
                      thickness: 20.0,
                    )
                    ],
                  ),
                );  
              },
            );}
          },
        ),
       
      ),

      

      drawer:  Drawer(
        child: ListView(
          children: <Widget>[
            //Header 
            UserAccountsDrawerHeader(
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person,color: Colors.white,),
                ),
              ),
              accountName: Text(name),
              accountEmail: Text(email),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
              ),

              //Body
              InkWell(
                onTap: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: ListTile(
                  title: Text('Home '),
                  leading: Icon(Icons.home,color: Colors.blue,),
                ),
              ),

              InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('My Account'),
                  leading: Icon(Icons.person,color: Colors.blue,),
                ),
              ),

              InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('My Writing'),
                  leading: Icon(Icons.edit,color: Colors.blue,),
                ),
              ),

       
              InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('My Favourites'),
                  leading: Icon(Icons.favorite,color: Colors.blue,),
                ),
              ),


              //line 
              Divider(),


              InkWell(
                onTap: (){
                  _showDialog();
                },
                child: ListTile(
                  title: Text('Log out'),
                  leading: Icon(Icons.move_to_inbox,color: Colors.blueGrey,),
                ),
              ),


              InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings,color: Colors.blueGrey,),
                ),
              ),

              InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('About'),
                  leading: Icon(Icons.info,color: Colors.blueGrey,),
                ),
              )

              
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(context, 
          MaterialPageRoute(
            builder: (context)=> AddWiting()
          ));
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
    ),

    );
  }
}

