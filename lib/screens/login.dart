import 'dart:html';

import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';


class Login extends StatefulWidget {

  @override 

  LoginState createState()=>LoginState();
}

class LoginState extends State<Login>{
  

  LoginState({Key? key});

  final formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xffFBF0EA),
      appBar: AppBar(title: Text('login'),backgroundColor:Color(0xffFB9555),),
      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
             Container(
               margin: EdgeInsets.all(20),
               child:Text('Login',textAlign: TextAlign.center,style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)
               ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 30),
                child: Text('Log in to your account',style: TextStyle(fontWeight: FontWeight.bold),),
              ),

          //login hero
          Container(
            height: 150,
            margin:EdgeInsets.all(20),
            decoration: BoxDecoration(color: Color(0xffFABE99),borderRadius: BorderRadius.all(Radius.circular(20))),
          ),


               Container(
                 //width: 280,

                 margin: EdgeInsets.only(left: 30,right: 30),
                 child: Form(child: TextFormField(
                     cursorColor: Color(0xff9F3647),
                     

                   decoration: InputDecoration(
                     
                     
                     focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff9F3647), width: 2.0),
                ),
                     focusColor: Color(0xff9F3647),

                     hintText: 'Your name',
                     filled: true,
                     fillColor: Color(0xffFABE99),
                      border: OutlineInputBorder(),
      //         focusedBorder: InputBorder.none,
      //            enabledBorder: InputBorder.none,
                   )
                 )),
               )

               //form
      //          Container(
      //            //color: Colors.red,
      //            width: 320,
      //            //alignment: Alignment.center,
      //            decoration: BoxDecoration(
      //              color: Colors.red,
      //              border: Border(bottom: BorderSide(width: 10,color: Color(0xff9F3647))),
      //            ),
      //            //decoration:BoxDecoration(color: Color(0xffFBF0EA),borderRadius: BorderRadius.all(Radius.circular(30)),border:Border.all(color: Color(0xff9F3647),width: 2)),
      //            child: Form(
      //            key: formKey,
      //            child: Column(
                   
      //            children: [
      //                TextFormField(
      //                  //cursorWidth: 200,
                       
      //   validator: (value) => !value!.contains('@') ? 'Not a valid email.' : null,
      //   onSaved: (val) => print('savied'),
      //  decoration: InputDecoration(
      //         focusedBorder: InputBorder.none,
      //            enabledBorder: InputBorder.none,
                 
      //            ///label: Text('Lodge'),
      //           hintText: 'Search for a lodge',
      //         border: null,
      //         //suffixIconColor: Colors.blue,
      //         //suffixIcon:IconButton(icon: Icon(Icons.search,size: 28, color: Color(0xff9F3647),),onPressed: (){print(myController.text);},color: Colors.red,),
      //       //labelText: 'Password',
      //     ),
      // ),

      // Row(children: [
       
      // ],)
      //            ],
      //          )
      //          ),
      //          )

      ]),
    );
  }
}