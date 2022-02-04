import 'dart:html';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:lodger/components/pickerData.dart';
import 'package:lodger/screens/profile.dart';
import 'package:lodger/components/room.dart';
import 'package:lodger/screens/roomdetails.dart';

//import 'PickerData.dart';




class Login extends StatefulWidget {

  @override 

  LoginState createState()=>LoginState();
}


// class PickerMenu extends StatelessWidget {

//   final double listSpec = 4.0;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   String stateText = "";


  
//   @override 
    
//     }

//     Widget build(BuildContext context){
//       return Container();
//     }
// }

class LoginState extends State<Login>{
  

  LoginState({Key? key});

  bool showPassword=true;

  IconData? passwordIcon=Icons.visibility_off;

  final formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  String? roomControler;
  final passwordController=TextEditingController();
  String? passwordValue;
  String? nameValue;
  bool loading=false;

  CollectionReference users=FirebaseFirestore.instance.collection('users');

  CollectionReference rooms=FirebaseFirestore.instance.collection('rooms');
  
  Future login() async {
    users.where('name',isEqualTo: nameValue).get()
    .then((QuerySnapshot value){

      
       
      if(value.docs[0]['password']==passwordValue){
        print('passwords match');
        setState(() {
        loading=false;
      });
      rooms.where('room', isEqualTo: roomControler).get()
      .then((QuerySnapshot data){
        //print(data.docs[0]['occupants']);
          Navigator.push(context,MaterialPageRoute(builder: (context)=>RoomDetails(floor: data.docs[0]['floor'], number: data.docs[0]['number'],paid: data.docs[0]['paid'],status: data.docs[0]['status'],
            power: data.docs[0]['power'], water: data.docs[0]['water']
            ,owing: data.docs[0]['owing']
            ,occupants:data.docs[0]['occupants'],problems:data.docs[0]['problems'],user:true
             
            )
           ));
      });

      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(name:value.docs[0]['name'] ,owing: value.docs[0]['owing'],paid: value.docs[0]['paid'],rent: value.docs[0]['rent'],room: value.docs[0]['room'],)));
      }
      else {
        print('wrong password');
      }
      
    });
  }


  showPickerArray(BuildContext context) {

    Picker(
       
        backgroundColor: Color(0xffFABE99),
         adapter: PickerDataAdapter(pickerdata: [['A','B','C','D'],['1','2','3','4','5','6','7','8','9','10',
        '11','12','13','14','15','16','17','18','19','20']],isArray: true),
        delimiter: [
          PickerDelimiter(child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: new Text("Please Select"),
        onConfirm: (Picker picker, List value) {
           setState(() {
            roomControler=picker.getSelectedValues().join("");
          });
          print(value.toString());
          print(picker.getSelectedValues());
        }
    ).showDialog(context);
  }
  

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
                 width: 350,

                 margin: EdgeInsets.only(left: 30,right: 30,top: 30),
                 child: Form(child: TextFormField(
                   
                     cursorColor: Color(0xff9F3647),
                     controller: myController,
                      onChanged: (String value){
                        setState(() {
                          nameValue=value;
                        });
                        print(nameValue);
                      },
                   decoration: InputDecoration(
                     prefixIcon: Icon(Icons.person),
                     
                     focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  
                  borderRadius: BorderRadius.all(Radius.circular(20)),
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
               ),
              // PickerMenu(),
             Container(
              
               margin: EdgeInsets.only(top: 20,bottom: 20,left: 40),
               alignment: Alignment.topLeft,
               child:  Row(children: [
                 Container(
                   decoration: BoxDecoration(border: Border.all(color:Color(0xff9F3647), ),borderRadius: BorderRadius.all(Radius.circular(20)),),
                   child: ElevatedButton(onPressed: (){showPickerArray(context);}, child: Text('Room Number',style: TextStyle(color: Colors.black),),style:ElevatedButton.styleFrom(primary: Color(0xffFABE99),shape: new RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(30.0),
    ), )),
                 ),
                 Container(
                   margin: EdgeInsets.only(left: 20),
                   decoration: BoxDecoration(
                     //color: Colors.red,
                   ),
                   child:Text(roomControler ?? '',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)
                 )
               ],)
             ),

             Container(
                 width: 350,
                 margin: EdgeInsets.only(left: 30,right: 30),
                 child: Form(child: TextFormField(
                    controller: passwordController,
                     cursorColor: Color(0xff9F3647),
                     obscureText: showPassword,
                      onChanged: (String value){
                          setState(() {
                            passwordValue=value;
                            //passwordControler=value;
                          });
                          print(passwordValue);
                      },
                   decoration: InputDecoration(
                     
                     prefixIcon: Icon(Icons.lock),
                     prefixIconColor: Color(0xff9F3647),
                     
                     focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.red, width: 2.0,),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Color(0xff9F3647), width: 2.0),
                ),
                     focusColor: Color(0xff9F3647),

                     hintText: 'Your Password',
                     filled: true,
                     fillColor: Color(0xffFABE99),
                      border: OutlineInputBorder(),
                      suffixIconColor: Color(0xff9F3647),
                      
                      suffixIcon: Container(
                   child: IconButton(icon: Icon(!showPassword ? Icons.visibility : Icons.visibility_off,color: Color(0xff9F3647),),onPressed: (){
                     setState(() {
                      //showPassword=true;
                      showPassword ? showPassword=false : showPassword=true;
                     });
                   },),
                 ),
                   )
                   
                 )),
               ),

               Container(
                 margin: EdgeInsets.only(right: 20),
                 alignment: Alignment.topRight,
                 child: TextButton(child: Text('Forgoten Password?',style: TextStyle(color: Color(0xff9F3647)),),onPressed: (){},),
               ),

               Container(
                 margin: EdgeInsets.only(top: 40),
                 child: ElevatedButton(child: loading ? CircularProgressIndicator(color: Colors.white,) : Text('Submit'),onPressed: (){
                   setState(() {
                     loading ? loading=false : loading=true;
                   });
                   print('room number $roomControler,name:$nameValue, password:$passwordValue');
                   login();
                 },
                 style: ElevatedButton.styleFrom(minimumSize: Size(330, 60),primary: Color(0xff9F3647),shape: new RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(20.0),
    ),),
                 
                 ),
               ),



               Container(
                 margin: EdgeInsets.only(top: 1),
                 alignment: Alignment.center,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                   Container(
                     margin: EdgeInsets.all(20),
                     width: 60,
                     height: 60,
                     
                     decoration: BoxDecoration(color: Color(0xffFABE99),borderRadius: BorderRadius.all(Radius.circular(10))),
                   ),

                   Container(
                     margin: EdgeInsets.all(20),
                     width: 60,
                     height: 60,
                     
                     decoration: BoxDecoration(color: Color(0xffFABE99),borderRadius: BorderRadius.all(Radius.circular(10))),
                   ),

                   Container(
                     margin: EdgeInsets.all(20),
                     width: 60,
                     height: 60,
                     
                     decoration: BoxDecoration(color: Color(0xffFABE99),borderRadius: BorderRadius.all(Radius.circular(10))),
                   ),

                   
                 ]),
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