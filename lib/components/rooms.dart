import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lodger/components/avatar.dart';
import 'package:flutter/material.dart';
import 'package:lodger/components/room.dart';

class AddRoom extends StatelessWidget {
  int? number;
  List? occupants;
  List? problems;
  bool? status;
  String? floor;
  bool? paid;
  AddRoom({@required this.number,@required this.occupants, @required this.floor, @required this.paid, @required this.status, this.problems, });
  

  CollectionReference users=FirebaseFirestore.instance.collection('rooms');

  Future<void> addRoom(){
    return users
        .add({
          'number':number,
          'floor':floor,
          'status':status,
          'paid':paid,
          'problems':problems,
          'occupants':occupants,
        })
        .then((value){
          print(value);
          print('added room');
        })
        .catchError((e){
          print(e);
          print('failed to save room');
        });
        
  }

  @override
  Widget build(BuildContext context){
    
    return Container();
    //ElevatedButton(onPressed:addUser, child: Text('Add user'));
  }
}

class Rooms extends StatefulWidget {

  // Stream<QuerySnapshot>? roomStream;
  // int? number;
  // List? occupants;
  // List? problems;
  // bool? status;
  // String? floor;
  // bool? paid;


  // Rooms({@required this.number,@required this.occupants, @required this.floor, @required this.paid, @required this.status, this.problems, @required this.roomStream});
  

  
  @override 

 //RoomState createState()=>RoomState(number: number,occupants: occupants,floor: floor,paid: paid,status: status);
RoomState createState()=>RoomState();

}

class RoomState extends State<Rooms> {
  
  int? number;
  List? occupants;
  List? problems;
  bool? status;
  String? floor;
  bool? paid;


  RoomState({@required this.number,@required this.occupants, @required this.floor, @required this.paid, @required this.status,});

  static String? floorNumber='A';

  final Stream<QuerySnapshot> roomStream = FirebaseFirestore.instance.collection('rooms').where('floor',isEqualTo: floorNumber).snapshots();


  void changeFloor(){
    setState(() {
      floorNumber='B';
    });
  }


   @override 
   Widget build(BuildContext context ){
     changeFloor(String letter){
    setState(() {
      floorNumber='B';
    });
  }
     return Column(
       children: [
            Expanded(
              flex: 4,
              child:  StreamBuilder(
              
              stream: roomStream,
              builder:(BuildContext context, AsyncSnapshot<QuerySnapshot>  snapshot){
                if (snapshot.hasError) {
          return Text("Something went wrong");
        }

                if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return GridView.count(
          //scrollDirection: Axis.horizontal,
          crossAxisCount: 2,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;


            return Room(floor: data['floor'], number: data['number'],paid: data['paid'],status: data['status'],);
          }).toList(),
        );
        
              } ,
              
            ) ,
            ),

            Align(alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget> [
                Container(
                  
                  child: IconButton(icon: Icon(Icons.looks_one),onPressed:(){
                    setState(() {
                      floorNumber='B';
                    });
                  }),
                  decoration: BoxDecoration(color: Color(0xffDC4749),borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                ),

                //floor 2

                Container(
                  child: IconButton(icon: Icon(Icons.looks_two),onPressed:changeFloor('B')),
                  decoration: BoxDecoration(color: Color(0xffDC4749),borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                ),

                //floor 3

                Container(
                  child: IconButton(icon: Icon(Icons.looks_3),onPressed:changeFloor('C')),
                  decoration: BoxDecoration(color: Color(0xffDC4749),borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                ),

                //floor 4

                Container(
                  child: IconButton(icon: Icon(Icons.looks_4),onPressed:changeFloor('D')),
                  decoration: BoxDecoration(color: Color(0xffDC4749),borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                )

              ],
            )
,
            )
       ],
      // child: ElevatedButton(child: Text('click'),onPressed:(){
      // AddRoom room=AddRoom(number: 5, occupants: ['nosa','jake',], floor: 'A', paid: true,problems: ['broken tap'],);
      //         room.addRoom();
      // },),
     );
   }
}