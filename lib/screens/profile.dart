import 'dart:html';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  String? name;
  String? room;
  int? rent;
  bool? paid;
  int? owing;
  String? password;
  Profile({ Key? key,this.name,this.room,this.rent,this.paid,this.owing }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBF0EA),
      appBar: AppBar(actions: []),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(children: [
             Container(
          child: Icon(Icons.account_circle,size: 200,color: Color(0xff9F3647),),
        ),
           
           Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Container(
                 margin: EdgeInsets.all(10),
                 child: Text(widget.name ?? '',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
               ),

                Container(
                  margin: EdgeInsets.all(10),
                 child: Text(widget.room ?? '',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               )
             ],
           )
          ],),

          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
                child: Text(''),
              )
            ]),
            height: 300,
            decoration:BoxDecoration(color: Color(0xffFABE99),borderRadius: BorderRadius.all(Radius.circular(20)))
          )
       
      ]),
    );
  }
}