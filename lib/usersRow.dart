import 'dart:html';

import 'package:flutter/material.dart';





class UsersRow extends StatefulWidget {

  @override 
   _UserState createState()=>_UserState();
}

class _UserState extends State<UsersRow> {
  final data;
  final users;
  _UserState({Key? key,this.data,this.users});

  @override 

  Widget build(BuildContext context){
    return Padding(padding: EdgeInsets.all(20),
    child: Row(children: [
      Container(
              decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(10)),color: Colors.grey,),
              height: 80,
              width: 80,
              margin: EdgeInsets.all(10),
              ),

      Container(
              decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(10)),color: Colors.grey,),
              height: 80,
              width: 80,
              margin: EdgeInsets.all(10)
              ),

      Container(
              decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(10)),color: Colors.grey,),
              height: 80,
              width: 80,
              margin: EdgeInsets.all(10)
              )
    ],),
    );
  }
}