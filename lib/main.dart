import 'dart:html';

import 'package:flutter/material.dart';
import 'package:lodger/appbar.dart';
import 'package:lodger/usersRow.dart';
import 'package:mongo_dart/mongo_dart.dart'  show Db, DbCollection;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'package:lodger/components/avatar.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class Top extends StatelessWidget {
  final image;
  final menu;
  const Top({this.image, this.menu});

  @override 
  Widget build(BuildContext context){
    return Container(
      
    );
  }
}






class AddUser extends StatelessWidget {
  final String? name;
  final String? room;
  final int? rent;
  final bool? paid;
  final int? owing;
  final String? password;

  AddUser({this.name,this.rent,this.owing,this.paid,this.room,this.password});

  CollectionReference users=FirebaseFirestore.instance.collection('users');

  Future<void> addUser(){
    return users
        .add({
          'name':name,
          'room':room,
          'rent':rent,
          'paid':paid,
          'owing':owing,
          'password':password,
        })
        .then((value){
          print(value);
          print('added user');
        })
        .catchError((e){
          print(e);
          print('failed to save user');
        });
        
  }

  @override
  Widget build(BuildContext context){
    
    return ElevatedButton(onPressed:addUser, child: Text('Add user'));
  }
}






class User {
  final String? name;
  final String? room;
  final String? rent;
  final bool? paid;

  User({this.name, this.room, this.rent, this.paid});

  

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      room: json['room'],
      rent: json['rent'],
      paid: json['paid']
    
    );
  }
   Map<String, dynamic> toJson() => {
    "name": name,
    "room": room,
  };

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override 
  
  _HomePageState createState()=>_HomePageState();
}




class _HomePageState extends State<MyHomePage> {
  //_HomePageState({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  String? title;
  // _HomePageState(){
  //   getData();
  // }

  bool drawerOpen=false;
  var name;

  
  void toggleDrawer(){
    //drawerOpen=!drawerOpen;
    //data.getUsers();
    print('ludex gundyr');
  }
  
  AddUser addUser=AddUser(
    name: 'judith',
    room: 'c9',
    rent: 137000,
    owing: 14000,
    paid: true,
    
  );
  CollectionReference users=FirebaseFirestore.instance.collection('users');
  
  // getData() async{
  //   return await users.doc('bmUlp2nAWAj9uJcV79sc').get()
  //   .then((DocumentSnapshot snapshot){
  //       //  setState(() {
  //       //    name=snapshot.data();
  //       //  });
  //       //  //var name1=snapshot['name'].data();
  //       //    print(name);
  //          //print(name1);
  //          print('gotten data');
  //   })
  //   .catchError((e){
  //     print(e);
  //     print('error');
  //   });
  // }

  
final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context){
    return Scaffold(

        body: Stack(children:<Widget> [
         Container(
           child:  MyAppbar(),

         height: 250,
         width: 500,
         ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Expanded(child: Container(
              //container holding the main body
            decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(80)),
            color: Color(0xffFBF0EA),
            
            ),
            child: Align(alignment: Alignment.topCenter,
            child:StreamBuilder<QuerySnapshot>(
              //future: users.doc('bmUlp2nAWAj9uJcV79sc').get(),
              stream: usersStream,
              builder:(BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
                if (snapshot.hasError) {
          return Text("Something went wrong");
        }

                if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return ListView(
          scrollDirection: Axis.horizontal,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          
            return Avatar(name: data['name']);
          }).toList(),
        );
        
              } ,
            )
            //child: UsersRow()
              // child: Column(children: [
              //   ElevatedButton(child: Text('click'),onPressed: getData,),
              //   ElevatedButton(onPressed: ()=>print(name['name']), child: Text('log'))
              // ],)
            ),
            width: 390,
            height: 650,
          ) ,)
          
          )
           
        ],)
    );
  }
}

