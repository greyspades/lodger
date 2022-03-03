import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:lodger/components/pickerData.dart';
import 'package:lodger/screens/profile.dart';
import 'package:lodger/components/room.dart';
import 'package:lodger/components/avatar.dart';
import 'package:lodger/appbar.dart';
import 'package:lodger/components/searchbar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



//listview for the users
class UserRow extends StatelessWidget {
  Stream<QuerySnapshot>? usersStream;
  UserRow({Key? key, this.usersStream});

  @override 
  Widget build(BuildContext context){
    return Align(alignment: Alignment.topCenter,
            child:StreamBuilder<QuerySnapshot>(
              //future: users.doc('bmUlp2nAWAj9uJcV79sc').get(),
              stream: usersStream,
              builder:(BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
                if (snapshot.hasError) {
          return Text("Something went wrong");
        }

                if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(color: Color(0xff9F3647),)
          );
        }
        return ListView(
          scrollDirection: Axis.horizontal,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          
            return  Align(
              alignment: Alignment.topCenter,
              
              child: Avatar(name: data['name'],room: 13,),
              //child: Container(child: Text('user'),),
              
            );
          }).toList(),
        );
        
              } ,
              
            )
            
            );

    //return Center();
  }
}

class Home extends StatelessWidget {
Stream<QuerySnapshot>? usersStream;
  Home({Key? key, this.usersStream});
  @override

  Widget build(BuildContext context){
    // return Column(children: [
      
    // ],);
    return Container(
      color: Color(0xffFABE99),
      child: Stack(children: [
       Container(
           child:  MyAppbar(),
           
         //decoration: BoxDecoration(color: Color(0xff9F3647),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))),
         height: 300,
         width: 550,
         ),

         //searchbar
         SearchBar(),

        Align(
          alignment: Alignment.bottomCenter,
          child:  Container(
           height: 430,
           color: Color(0xffFABE99),
           child:ListView(
             children: [
             Container(
               margin: EdgeInsets.only(top: 30),
               height: 100,
               child: ListView(
                 
               scrollDirection: Axis.horizontal,
               children: [

                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xff5D2749),fixedSize: Size(100,100),shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: (){}, child:Text('')),
                ),


                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xff5D2749),fixedSize: Size(100,100),shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: (){}, child:Text('')),
                ),


                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xff5D2749),fixedSize: Size(100,100),shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: (){}, child:Text('')),
                )


               
             ],),
             )
           ],)
         ),
        )
          

         // top rounded body
    //     Container(
          
    //       height: 300,
    //       color: Color(0xffFABE99),
    //   //decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
    //   //color: Colors.grey,
    //   child: Stack(

    //   children: [

    //   Container(
    //     //height: 400,
    //     //color: Color(0xffFABE99),
    //   )
        
    // //     Container(
    // //         margin: EdgeInsets.only(top: 200),
    // //          height: 600,
    // //           //container holding the main body
    // //         decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
    // //         //color: Color(0xffFBF0EA),
    // //         //color: Colors.orange
    // //         //color: Colors.green
            
            
    // //         ),
    // //         //child: screens[0],
    // //         child: Column(children: [

    // //           //row
    // //         //  Container(
    // //         //    height: 100,
    // //         //    child:  UserRow(usersStream: usersStream,),
    // //         //  ),


    // //           Align(
    // //    alignment: Alignment.center,
    // //    child: Container(
    // //     //alignment: Alignment.bottomCenter,
    // //     child: Container(alignment: Alignment.center,
    // //     child: Text('messages'),
    // //     ),
    // //     decoration: BoxDecoration(color: Color(0xffFABE99),borderRadius: BorderRadius.all(Radius.circular(20))),
    // //     width: 350,
    // //     height: 300,
    // //     margin: EdgeInsets.only(top:100),
        
    // //   ),
    // //  )
    // //         ]),
    // //         //child: Home(usersStream: userStream),
           
    // //       )
     
    //   ],
    // ),
    // )
    ],),
    );
  }
}