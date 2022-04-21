
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:lodger/components/pickerData.dart';
import 'package:lodger/screens/profile.dart';
import 'package:lodger/components/room.dart';
import 'package:lodger/screens/roomdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lodger/screens/roominfo.dart';
import 'package:intl/intl.dart';

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
  
  Future<void> login() async {
    final SharedPreferences prefs = await _prefs;

    //* get the user information
    users.where('name',isEqualTo: nameValue).get()
    .then((QuerySnapshot value){
      if(value.docs[0]['password']==passwordValue){
        print('passwords match');
        prefs.setBool('logged in',true);
        prefs.setString('room',roomControler ?? '');
        prefs.setString('user',nameValue ?? '');
        setState(() {
        loading=false;
      });

      //* get the room information
      rooms.where('room', isEqualTo: roomControler).get()
      .then((QuerySnapshot data)async{
        prefs.setBool('paid', data.docs[0]['paid']);
        prefs.setBool('status', data.docs[0]['status']);
        prefs.setInt('owing', data.docs[0]['owing']);
        prefs.setString('image', data.docs[0]['image']);
        
        //String? mates=json.encode(data.docs[0]['problems']);
       

        //prefs.setString('occupants', data.docs[0]['problems']);

        //* converts the timestamp of the problems objects to formated time
        List<dynamic> list= data.docs[0]['problems'].map((d){
          return {
            'item':d['item'],
            'fixed':d['fixed'],
            'time':DateFormat.yMMMd().format(d['time'].toDate())
          } ;
        }).toList();
        //* encode the problems object into a json string
        String? prob=json.encode(list);
        String? occ=json.encode(data.docs[0]['occupants']);
        
        prefs.setString('occupants', occ);

       prefs.setString('problems', prob);
        
        prefs.setString('floor', data.docs[0]['floor']);
        prefs.setString('room', data.docs[0]['room']);
       
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Info(
            floor: data.docs[0]['floor'], number: data.docs[0]['number'],
            paid: data.docs[0]['paid'],status: data.docs[0]['status'],
            //mail:data.docs[0]['mail'],
            owing: data.docs[0]['owing']
            ,occupants:data.docs[0]['occupants'],
            problems:data.docs[0]['problems'],
            image:data.docs[0]['image'],
            user:true
             
            )
           ));
      })
      .catchError((e){
        print(e);
        setState(() {
          loading=false;
        });
      });

      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(name:value.docs[0]['name'] ,owing: value.docs[0]['owing'],paid: value.docs[0]['paid'],rent: value.docs[0]['rent'],room: value.docs[0]['room'],)));
      }
      else {
        print('wrong password');
        setState(() {
          loading=false;
        });
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

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  setInfo() async{
     final SharedPreferences prefs = await _prefs;
     prefs.setBool('logged in', true);
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
                     //contentPadding: EdgeInsets.only(top: 25,bottom: 25),
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
                height: 100,

              )

              //  Container(
              //    margin: EdgeInsets.only(top: 100),
              //    alignment: Alignment.center,
              //    child: Row(
              //      mainAxisAlignment: MainAxisAlignment.center,
              //      children: [
              //      Container(
              //        margin: EdgeInsets.all(20),
              //        width: 60,
              //        height: 60,
                     
              //        decoration: BoxDecoration(color: Color(0xffFABE99),borderRadius: BorderRadius.all(Radius.circular(10))),
              //      ),

              //      Container(
              //        margin: EdgeInsets.all(20),
              //        width: 60,
              //        height: 60,
                     
              //        decoration: BoxDecoration(color: Color(0xffFABE99),borderRadius: BorderRadius.all(Radius.circular(10))),
              //      ),

              //      Container(
              //        margin: EdgeInsets.all(20),
              //        width: 60,
              //        height: 60,
                     
              //        decoration: BoxDecoration(color: Color(0xffFABE99),borderRadius: BorderRadius.all(Radius.circular(10))),
              //      ),

                   
              //    ]),
              //  )
                
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