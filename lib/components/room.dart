 import 'package:flutter/material.dart';

// class Room extends StatefulWidget {
  
//   int? number;
//   List? occupants;
//   List? problems;
//   bool? status;
//   String? floor;
//   bool? paid;


//   Room({@required this.number,this.occupants, @required this.floor, @required this.paid, @required this.status,});
//   // static Color? roomState;
  
//   @override
//    RoomObject createState()=> RoomObject(number: number,occupants: occupants,floor: floor,paid: paid,status: status);
// }


// class RoomObject extends State<Room> {

//   int? number;
//   List? occupants;
//   List? problems;
//   bool? status;
//   String? floor;
//   bool? paid;


//   RoomObject({@required this.number,this.occupants, @required this.floor, @required this.paid, @required this.status,});

//   static Color? roomState;

//   @override 
//    Widget build(BuildContext context){
//      return Column(children: [
//        IconButton(onPressed: (){
//          print('occupants');
//        }, icon: Icon(Icons.apartment),color: roomState,),

//        Text(number.toString())
//      ],);
//    }
// }



class Room extends StatelessWidget {

  int? number;
  List? occupants;
  List? problems;
  bool? status;
  String? floor;
  bool? paid;


  Room({@required this.number,this.occupants, @required this.floor, @required this.paid, @required this.status,});

  Color? roomColor;

  
    

  @override 
   Widget build(BuildContext context){
     if(status==false){
      roomColor=Colors.orange;
    }
    // else if(status==false){
    //   roomColor==Colors.orange;
    // }
    //status? roomColor=Colors.red;
   
     return Column(children: [
       IconButton(onPressed: (){
         print('occupants');
       }, icon: Icon(Icons.apartment),color: roomColor, iconSize: 100, ),

       Text(number.toString())
     ],);
   }
}