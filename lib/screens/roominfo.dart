import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
      });

 

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  CollectionReference room=FirebaseFirestore.instance.collection('rooms');

  String? floor;
  IconData? iconSelector;
  bool? loading=false;
  bool? resolved=false;

  getData() async {
    print('getting room data');
    setState(() {
      loading=true;
      
    });
     final SharedPreferences prefs=await _prefs;
    String? roomKey=prefs.getString('room');
    room.where('room', isEqualTo: roomKey).get()
    .then((QuerySnapshot value){
      print('found room');
        setState(() {
          loading=false;
          resolved=true;
          floor=value.docs[0]['floor'];
        });
        //print(value.docs[0]['floor']);
        print('the floor is $floor');
    });
  }
  

  @override
  void initState() {
   getData();
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    if(widget.paid==true && widget.status==true){
      iconSelector=Icons.door_front_door;
    }
    else if((widget.paid)==false && widget.status==true){
      iconSelector=Icons.meeting_room;
    }
    else if(widget.status==false){
      iconSelector=Icons.room_preferences;
    }
    return Scaffold(
      backgroundColor: Color(0xffFBF0EA),
      //appBar: 
      body:  Stack(
        alignment: Alignment.center,
      children: [
        // hero section
        Column(
          //height: 60,
          children:[
            AppBar(backgroundColor: Color(0xffFABE99),elevation: 0,iconTheme: IconThemeData(color: Colors.black),),
            Container(
              padding: EdgeInsets.all(10),
              height: 200,
              color: Color(0xffFABE99),
              child: Row(children: [
                Container(
                  child: Icon(iconSelector),
                )
              ]),
            )
          ],
        ),

        //round top border body

      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(30)),color: Color(0xffFBF0EA)),
        height: 600,
        margin: EdgeInsets.only(top: 150),
        // width: 100,
        //child: !(loading ?? false) && (resolved ?? false) ? Text('details'):CircularProgressIndicator(),
      ),
     
      ],
      )
    );
  }
}