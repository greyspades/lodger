//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:lodger/appbar.dart';
//import 'package:lodger/usersRow.dart';
//import 'package:mongo_dart/mongo_dart.dart'  show Db, DbCollection;
//import 'package:http/http.dart' as http;
//import 'dart:async';
//import 'dart:convert';
//import 'dart:developer' as developer;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:developer';
import 'package:lodger/components/avatar.dart';
import 'package:lodger/components/rooms.dart';
import 'package:lodger/components/room.dart';
import 'package:lodger/screens/roomdetails.dart';
import 'package:lodger/screens/login.dart';
import 'package:lodger/components/searchbar.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:lodger/screens/roominfo.dart';





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






// class User {
//   final String? name;
//   final String? room;
//   final String? rent;
//   final bool? paid;

//   User({this.name, this.room, this.rent, this.paid});

  

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       name: json['name'],
//       room: json['room'],
//       rent: json['rent'],
//       paid: json['paid']
    
//     );
//   }
//    Map<String, dynamic> toJson() => {
//     "name": name,
//     "room": room,
//   };

// }






class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        //primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes:  <String, WidgetBuilder>{
        '/a': (BuildContext context) => MyHomePage(),
        '/b': (BuildContext context) => RoomDetails(),
      },
      
    );
  }
}


class Home extends StatelessWidget {
Stream<QuerySnapshot>? usersStream;
  Home({Key? key, this.usersStream});
  @override

  Widget build(BuildContext context){
    // return Column(children: [
      
    // ],);
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
      //color: Colors.grey,
      child: Stack(

      children: [UserRow(usersStream: usersStream,),
     Align(
       alignment: Alignment.center,
       child: Container(
        //alignment: Alignment.bottomCenter,
        child: Container(alignment: Alignment.center,
        child: Text('messages'),
        ),
        decoration: BoxDecoration(color: Color(0xffFABE99),borderRadius: BorderRadius.all(Radius.circular(20))),
        width: 350,
        height: 300,
        margin: EdgeInsets.only(top:100),
        
      )
     )
      ],
    ),
    );
  }
}



class UserRow extends StatelessWidget {
  Stream<QuerySnapshot>? usersStream;
  UserRow({Key? key, this.usersStream});

  @override 
  Widget build(BuildContext context){
    return Align(alignment: Alignment.topCenter,
            child:StreamBuilder<QuerySnapshot>(
              //future: users.doc('bmUlp2nAWAj9uJcV79sc').get(),
              stream: usersStream,
              builder:(BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
                if (snapshot.hasError) {
          return Text("Something went wrong");
        }

                if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(color: Color(0xff9F3647),)
          );
        }
        return ListView(
          scrollDirection: Axis.horizontal,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          
            return  Align(
              alignment: Alignment.topCenter,
              
              child: Avatar(name: data['name'],room: 13,),
              //child: Container(child: Text('user'),),
              
            );
          }).toList(),
        );
        
              } ,
              
            )
            
            );

    //return Center();
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
  //Stream<QuerySnapshot>? userStream;

  final Stream<QuerySnapshot> userStream = FirebaseFirestore.instance.collection('users').snapshots();

  //final Stream<QuerySnapshot> roomStream = FirebaseFirestore.instance.collection('rooms').snapshots();
  

 int _selectedIndex=0;
 CollectionReference users=FirebaseFirestore.instance.collection('users');
  
 
  


  //bottom navbar handler

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


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
  

  @override
  Widget build(BuildContext context){
     List<Widget> screens=[
    Home(usersStream: userStream),
    Rooms(),
    Info(),
    //Login(),
  ];
    return Scaffold(

        body: Stack(children:<Widget> [
         Container(
           child:  MyAppbar(),
          color: Color(0xff9F3647),
         height: 300,
         width: 550,
         ),

          SearchBar(),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Expanded(child: Container(
              padding: EdgeInsets.only(
                //top: 5,
                //left: 10
                //,right: 10
                ),
              //container holding the main body
            decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
            color: Color(0xffFBF0EA),
            //color: Colors.green
            
            
            ),
            //child: screens[0],
            child: screens.elementAt(_selectedIndex),
            //child: Home(usersStream: userStream),
            width: 390,
            height: 520,
          ) ,)
          
          )
           
        ],),

        bottomNavigationBar:BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',

            backgroundColor: Color(0xff9F3647),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensor_door),
            label: 'Rooms',
             backgroundColor: Color(0xff9F3647),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_repair_service),
            label: 'Problems',
            backgroundColor: Color(0xff9F3647),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Requests',
             backgroundColor:Color(0xff9F3647) ,
          ),
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xffFB9555),
        onTap: _onItemTapped,
      ),
    );

    
  }
}

