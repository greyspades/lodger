 import 'package:flutter/material.dart';
import 'package:lodger/main.dart';
import 'package:lodger/screens/roomdetails.dart';
 


class Room extends StatelessWidget {

  int? number;
  List? occupants;
  List? problems;
  bool? status;
  String? floor;
  bool? paid;
  bool? water;
  bool? power;
  int? owing;


  Room({@required this.number,this.occupants, @required this.floor, @required this.paid, @required this.status,this.water,this.power,this.owing,this.problems});

  Color? roomColor;

  IconData? iconSelector;
  
    

  @override 
   Widget build(BuildContext context){
     if(paid==true && status==true){
      iconSelector=Icons.door_front_door;
    }
    else if(paid==false && status==true){
      iconSelector=Icons.meeting_room;
    }
    else if(status==false){
      iconSelector=Icons.room_preferences;
    }
    
   
     return Column(children: [
       Hero(tag: 'room-hero', child: IconButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>RoomDetails(floor: floor,number: number,occupants: occupants,paid: paid,status: status,problems: problems,icon: iconSelector,owing: owing,power: power,water: water,)));
       }, icon: Icon(iconSelector),color: Color(0xff9F3647), iconSize: 100, ),),

       Text('$floor'+ number.toString()),
     ],);
   }
}