

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:lodger/components/avatar.dart';
import 'package:expandable/expandable.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lodger/components/notifications.dart';




class Info extends StatefulWidget {
  int? number;
  List? occupants;
  List? problems;
  bool? status;
  String? floor;
  bool? paid;
  IconData? icon;
  bool? water;
  bool? power;
  int? owing;
  bool? user;
  String? room;
  String? id;
  String? image;

  Info(
      {@required this.number,
      @required this.occupants,
      @required this.floor,
      @required this.paid,
      @required this.status,
      this.problems,
      this.icon,
      this.owing,
      this.power,
      this.water,
      this.user,
      this.room,
      this.id,
      this.image
      });

 

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  CollectionReference room=FirebaseFirestore.instance.collection('rooms');

  
  IconData? iconSelector;
  bool? loading=false;
  bool? resolved=false;
  String? name;

  //check if the screen is navigated from the tab bar
  bool? user=false;
  
  //room object
  QueryDocumentSnapshot? info ;

 String? number;
  List? occupants;
  List? problems;
  bool? status;
  String? floor;
  bool? paid;
  IconData? icon;
  bool? water;
  bool? power;
  int? owing;
  List? mail;
  String? id;
  String? image;

  
 //index of the tapped navigation bar item
 int _selectedIndex=0;

 


  //display payment modal
  _showModalBottomSheet()
  {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration( color: Color(0xffFBF0EA),borderRadius: BorderRadius.vertical(top: Radius.circular(40)),),
            height: 200,
            //decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            width: double.infinity,
           
            alignment: Alignment.center,
            child: Column(children: [
              Text('Enter new problem',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              
              Container(
                height: 150,
                  child: TextFormField(decoration: InputDecoration(border:OutlineInputBorder(),
                 
                 ),
                 style: TextStyle(),
                 )
              )
            ],)
          );
        });}


  Future getData() async {
    final SharedPreferences prefs=await _prefs;
      String? imageString=await prefs.getString('image');
      String?floorData=await prefs.getString('floor');
      String? numberData=await prefs.getString('room');
      //String? numberData='carl';
       bool? paidData=await prefs.getBool('paid');
       int? owingData=await prefs.getInt('owing');
       String? probs=prefs.getString('problems');
       List? prob=json.decode(probs ?? '');

        String? mate=prefs.getString('occupants');
       List? mates=json.decode(probs ?? '');
       //List<String> problemsData=json.decode(source);
      //List<String> occupantData=json.decode((prefs.getString('occupants')) ?? '');
      
      //mail=json.decode(prefs.getString('mail'));
    setState((){
      floor=floorData;
       paid=paidData;
      owing=owingData;
      problems=prob;
      image=imageString;
      //occupants=occupantData;
      number=numberData;

    });

  }
  
  //handles the bottom navigation bar being tapped
  void _onItemTapped(int index) {
    // setState(() {
    //   _selectedIndex = index;
    // });

  }
  

  Future getName() async {
    final SharedPreferences prefs=await _prefs;
    String? username=prefs.getString('user');
    
    //String? numb=prefs.getString('room');
    //String? userRoom=prefs.getString('room');
    //print(prob);

    setState(() {
      name=username;
      //number=numb;
    });
  }
  

  @override
  void initState() {
   getData();
   
    // TODO: implement initState
    super.initState();
    getName();

  }

  @override
  Widget build(BuildContext context) {
    
final Stream<QuerySnapshot> mailStream = FirebaseFirestore.instance.collection('rooms').where('room',isEqualTo:number ).snapshots();
    IconData? iconSelector;

    if(info?['paid']==true && info?['status']==true){
      iconSelector=Icons.door_front_door;
    }
    else if((info?['paid'])==false && info?['status']==true){
      iconSelector=Icons.meeting_room;
    }
    else if(info?['status']==false){
      iconSelector=Icons.room_preferences;
    }
    return Scaffold(
      //backgroundColor: Color(0xffF4CBB1),
      backgroundColor: Colors.black,
      //appBar: 
      body:  Stack(
        alignment: Alignment.center,
      children: [
        // hero section
        Column(
          //height: 60,
          children:[

            //hero
           Container(
             height: 220,
             child:  AppBar(backgroundColor: Color(0xffFABE99),elevation: 0,iconTheme: IconThemeData(color: Color(0xff9F3647)),actions: [

              //user avatar
              


               Container(
                 margin: EdgeInsets.only(right: 20,top:10,bottom: 10),
                 child: Text(number ?? 'loading',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
               )
            ],
            flexibleSpace:AspectRatio(aspectRatio: 400/50,
            child:Image(
              //opacity: 0.5,
              color: Colors.white.withOpacity(0.8),
               colorBlendMode: BlendMode.modulate,
              image: NetworkImage((image ?? 'images/room5.jpg')),
             fit: BoxFit.cover,
             //width: 390,
            ) ,
            ),
            bottom: PreferredSize(child:Container(
            //color: Colors.brown,
            margin: EdgeInsets.only(bottom: 100,left: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Container(
                  //color: Colors.blue,
                  // margin: EdgeInsets.only(bottom: 40,left: 40),
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                  ),

                ),

                Container(
                  margin: EdgeInsets.only(left: 20),
                  height: 100,
                 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Text('Hi $name',style:TextStyle(fontSize:35,fontWeight: FontWeight.w900,color: Colors.white ),),
                  ]),
                )

            ]),
          ) ,preferredSize: Size.fromHeight(300),),
            ),
           ),
           
          

          ],
        ),

        //round top border body

      Container(
        
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(40)),color: Color(0xffFABE99)),
        height: 600,
        margin: EdgeInsets.only(top: 200),
        // width: 100,
        //child: !(loading ?? false) && (resolved ?? false) ? Text('details'):CircularProgressIndicator(),


        //column for body
        child: Expanded(
          child: ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

              //home
             Column(children: [
                ElevatedButton(onPressed: (){
                  setState(() {
                    _showModalBottomSheet();
                  });
                }, 
              //child: Icon(Icons.home),
              child:Icon(Icons.restaurant,color: Color(0xff9F3647),),
              style: ElevatedButton.styleFrom(primary: Color(0xffFBF0EA),fixedSize: Size(80,70), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
              Text('Dinning',style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
              ],),

             Column(children: [
                ElevatedButton(onPressed: (){}, 
              //child: Icon(Icons.home),
              child:Icon(Icons.payment,color: Color(0xff9F3647),),
              style: ElevatedButton.styleFrom(primary: Color(0xffFBF0EA),fixedSize: Size(80,70), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
              Text('Payments',style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
              ],),

              Column(children: [
                ElevatedButton(onPressed: (){}, 
              //child: Icon(Icons.home),
              child:Icon(Icons.error,color: Color(0xff9F3647),),
              style: ElevatedButton.styleFrom(primary: Color(0xffFBF0EA),fixedSize: Size(80,70), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
              Text('Problems',style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
              ],),

              Column(children: [
                ElevatedButton(onPressed: (){}, 
              //child: Icon(Icons.home),
              child:Icon(Icons.feedback,color: Color(0xff9F3647),),
              style: ElevatedButton.styleFrom(primary: Color(0xffFBF0EA),fixedSize: Size(80,70), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
              Text('Suggestions',style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
              ],)



            ]),
          ),
          
          //problems
          
         Container(
           
           height: 470,
           //color: Colors.blue,
           child: ListView(children: [
              Container(
            margin: EdgeInsets.only(top: 10,left: 10),
            alignment: Alignment.topLeft,
            child:Row(children: [Text('Pending issues',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),Icon(Icons.home_repair_service,color: Color(0xff9F3647),size: 22,)]) 
          ),


          Container(
            height: 120,
            child:ListView(
              children:problems!.map<Widget>((e){
                if(!e['fixed']){
                  return Container(
                  padding: EdgeInsets.only(top: 5,bottom: 5,left: 10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Color(0xffFBF0EA),borderRadius:BorderRadius.all(Radius.circular(5)) ),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children:<Widget> [
                      Text(e['item'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16 ),),
                      ElevatedButton(onPressed: (){}, child:Icon(Icons.build_circle),style: ElevatedButton.styleFrom(primary: Color(0xff9F3647)), )
                    ]),
                );
                }
                else {
                  return Container(
                    decoration: BoxDecoration(color:Color(0xff5D2749),
                    borderRadius: BorderRadius.all(Radius.circular(10)) ),
                    height: 150,
                    child:Row(children: [
                      Container(
                        child: Text('Room is in optimum condition',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ]) ,
                  );
                }
              }).toList(),
            ),
          ),

          //ElevatedButton(onPressed: (){print(problems);}, child: Text('print problems')),


          //* Notifications section
          Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child:Row(children: [Text('New Notifications',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),Icon(Icons.mail,color: Color(0xff9F3647),size: 22,)]) 
          ),
          
          Notifications(mailStream: mailStream,),

          // Container(
          //   height: 200,
          //   child:ListView(
          //     scrollDirection: Axis.horizontal,
          //     children: [
          //                Column(children: [
          //       ElevatedButton(onPressed: (){}, 
          //     //child: Icon(Icons.home),
          //     child:Icon(Icons.payment,color: Color(0xff9F3647),),
          //     style: ElevatedButton.styleFrom(primary: Color(0xff9F3647),fixedSize: Size(90,90), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          //     ),
          //     Text('Payments',style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
          //     ],),

          //        Column(children: [
          //       ElevatedButton(onPressed: (){}, 
          //     //child: Icon(Icons.home),
          //     child:Icon(Icons.payment,color: Color(0xff9F3647),),
          //     style: ElevatedButton.styleFrom(primary: Color(0xff9F3647),fixedSize: Size(90,90), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          //     ),
          //     Text('Payments',style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
          //     ],),

          //        Column(children: [
          //       ElevatedButton(onPressed: (){}, 
          //     //child: Icon(Icons.home),
          //     child:Icon(Icons.payment,color: Color(0xff9F3647),),
          //     style: ElevatedButton.styleFrom(primary: Color(0xff9F3647),fixedSize: Size(90,90), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          //     ),
          //     Text('Payments',style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
          //     ],),

          //        Column(children: [
          //       ElevatedButton(onPressed: (){}, 
          //     //child: Icon(Icons.home),
          //     child:Icon(Icons.payment,color: Color(0xff9F3647),),
          //     style: ElevatedButton.styleFrom(primary: Color(0xff9F3647),fixedSize: Size(90,90), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          //     ),
          //     Text('Payments',style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),)
          //     ],),
          // ],)
          //   ,)
          
          
           ]),
         )
        ])),
      ),
     
      ],
      ),
      
    );
  }
}