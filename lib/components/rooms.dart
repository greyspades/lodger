import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lodger/components/avatar.dart';
import 'package:flutter/material.dart';
import 'package:lodger/components/room.dart';
import 'package:lodger/main.dart';

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
_RoomState createState()=>_RoomState();

}

class _RoomState extends State<Rooms> {
  
  // int? number;
  // List? occupants;
  // List? problems;
  // bool? status;
  // String? floor;
  // bool? paid;


  // _RoomState({@required this.number,@required this.occupants, @required this.floor, @required this.paid, @required this.status,});

  

static String floorNumber='A';

  

     changeFloor(String f){
    setState(() {
      floorNumber=f;
    });
    print('updated floor state to $f');
  }
  


   @override 
   Widget build(BuildContext context ){
     final Stream<QuerySnapshot> roomStream = FirebaseFirestore.instance.collection('rooms').where('floor',isEqualTo: floorNumber).snapshots();
    //  changeFloor(String letter){
    // setState(() {
    //   floorNumber='B';
    // });
  //}
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


            return Room(floor: data['floor'], number: data['number'],paid: data['paid'],status: data['status'],
            power: data['power'], water: data['water']
            ,owing: data['owing']
            ,occupants:data['occupants'],problems:data['problems']
             
            );
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
                  
                  child: IconButton(icon: Icon(Icons.looks_one,color: Color(0xffDC4749),size: 40,),onPressed:(){
                    changeFloor('A');
                    //Navigator.push(context,MaterialPageRoute(builder: (context)=>RoomDetails()));
                  }),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left:10 ,right: 10, bottom: 10),
                ),

                //floor 2

                Container(
                  child: IconButton(icon: Icon(Icons.looks_two,color: Color(0xffDC4749),size: 40,),onPressed:(){changeFloor('B');}),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left:10 ,right: 10, bottom: 10),
                ),

                //floor 3

                Container(
                  child: IconButton(icon: Icon(Icons.looks_3,color: Color(0xffDC4749),size: 40,),onPressed:(){changeFloor('C');}),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left:10 ,right: 10, bottom: 10),
                ),

                //floor 4

                Container(
                  child: IconButton(icon: Icon(Icons.looks_4,color: Color(0xffDC4749),size: 40),onPressed:(){changeFloor('D');}),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left:10 ,right: 10, bottom: 10),
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