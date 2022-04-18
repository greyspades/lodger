import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:lodger/components/pickerData.dart';
import 'package:lodger/screens/profile.dart';
import 'package:lodger/components/room.dart';
import 'package:lodger/components/avatar.dart';
import 'package:lodger/appbar.dart';
import 'package:lodger/components/searchbar.dart';
import 'package:firebase_storage/firebase_storage.dart';



//*listview for the users


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
CollectionReference fireRef=FirebaseFirestore.instance.collection('rooms');

//* adding a new room to the database
  Future<void> addRoom(){
    return  fireRef.add({
      'floor':'B',
      'key':'roomB12',
      'number':12,
      'owing':100,
      'paid':true,
      'room':'B12',
      'status':false,
      'price':720,
      'pay-date':Timestamp.now(),
      'problems':[
        {
          'item':'Can hear voices at night',
          'fixed':false,
          'time':Timestamp.now()
        },
         {
          'item':'Broken toilet',
          'fixed':false,
          'time':Timestamp.now()
        }
      ],
      'occupants':['zainab,juliet'],
      'image':'https://firebasestorage.googleapis.com/v0/b/lodger-bf115.appspot.com/o/room4.jpg?alt=media&token=84a9b008-a1f5-49d4-b54d-0dab0210e1aa',
      'mail':[{
        'critical':false,
        'item':'There will be a party at the mail hall on friday night and you were invited',
        'read':false,
        'reciever':'B12',
        'sender':'management',
        'subject':'Party on friday night',
        'time':Timestamp.now(),
       
      },
      {
        'critical':false,
        'item':'Your ID card was found on the floor of the restaurant, please come to the security department to collect it',
        'read':false,
        'reciever':'B12',
        'sender':'Restaurant',
        'subject':'Found your ID card',
        'time':Timestamp.now(),
        
      },
      // {
      //   'critical':false,
      //   'item':'',
      //   'read':false,
      //   'reciever':'B7',
      //   'sender':'Littering penalty',
      //   'subject':"You were caught littering the premisses and you have been fined ${'100'} ",
      //   'time':Timestamp.now(),

      // },
      ]
    }).then((value) => print('stored')).catchError((err)=>print(err));
  }

  Future<String> getImage()async{

    //* ref for targeting the firebase storage bucket
    final storage=FirebaseStorage.instance.refFromURL('gs://lodger-bf115.appspot.com/room1.jpg');

    final image=storage.child('gs://lodger-bf115.appspot.com/room1.jpg');

    final items=await image.listAll();

    String url=await storage.getDownloadURL();

    //print('the items are $image');
    print('the url is ${url.toString()}');
    return url.toString();
  }

  Stream rooms=FirebaseFirestore.instance.collection('rooms').where('floor', isEqualTo: 'B').snapshots();

  @override

  Widget build(BuildContext context){
    

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
           height: 400,
           //color: Colors.red,
           //color: Color(0xffFABE99),
           child: Column(children: [
             Container(
               margin: EdgeInsets.only(bottom: 10),
           child: Text('Best rooms',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
         ),

             StreamBuilder(
             stream: rooms,
             builder: (BuildContext context, AsyncSnapshot snapshot){
                  if (snapshot.hasError) {
          return Text("Something went wrong");
        }

                if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(color: Color(0xff9F3647),)
          );
            }
            
            return Container(
              //color: Colors.black,
              margin: EdgeInsets.only(bottom: 50),
              height: 300,
              child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data.docs.map<Widget>((d){
                Map<String,dynamic> data=d.data() as Map<String,dynamic>;

                return Container(
                  height: 200,
                  width: 250,
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xff5D2749),shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: (){
                  //addRoom();
                }, child:Column(children: [
                  AspectRatio(
                  aspectRatio: 230/280,
                  child: Image.network(
                    d['image']
                  ,width: 200,height:230,fit: BoxFit.cover,)
                  
                  ),
                  //*room details
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(d['room'],style: TextStyle(fontSize: 20),),
                      Text(d['price'].toString(),style: TextStyle(fontSize: 20),)
                    
                    ]),
                  )
                ],)
                )
                );
              }).toList(),
            ),
            );
          
             })
           ]),
          //  child:ListView(
          //    children: [
          //    Container(
          //      margin: EdgeInsets.only(top: 30),
          //      height: 320,
          //      child: ListView(
                 
          //      scrollDirection: Axis.horizontal,
          //      children: [
          //       Container(
          //         height: 300,
          //         width: 250,
          //         margin: EdgeInsets.only(left: 10,right: 10),
          //         child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(primary: Color(0xff5D2749),fixedSize: Size(200,150),shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
          //       onPressed: (){
          //         //addRoom();
          //       }, child:AspectRatio(
          //         aspectRatio: 230/300,
          //         child: Image.network(
          //           //'https://firebasestorage.googleapis.com/v0/b/lodger-bf115.appspot.com/o/room1.jpg?alt=media&token=e69464a0-ddfa-4443-8d65-941937d3aca7'
          //             'https://firebasestorage.googleapis.com/v0/b/lodger-bf115.appspot.com/o/room14.jpg?alt=media&token=aa52b541-b2e4-4290-8100-b18df40cbf79'
          //         ,width: 200,height:230,fit: BoxFit.cover,)),
          //       )
          //       )
          //       ,


          //       Container(
          //         height: 250,
          //         width: 200,
          //         margin: EdgeInsets.only(left: 10,right: 10),
          //         child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(primary: Color(0xff5D2749),fixedSize: Size(200,150),shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
          //       onPressed: (){
          //         //addRoom();
          //       }, child:AspectRatio(
          //         aspectRatio: 200/250,
          //         child: Image.network('https://firebasestorage.googleapis.com/v0/b/lodger-bf115.appspot.com/o/room15.jpg?alt=media&token=8352e092-b319-4c64-ab66-ee6cb1418f29',width: 200,height:230,fit: BoxFit.cover,)),
          //       )
          //       ),


          //       Container(
          //         margin: EdgeInsets.only(left: 10,right: 10),
          //         child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(primary: Color(0xff5D2749),fixedSize: Size(200,250),shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
          //       onPressed: (){}, child:Text('')),
          //       )


               
          //    ],),
          //    ),

          //    ElevatedButton(onPressed: (){
          //      addRoom();
          //    }, child: Text('add room'))
          //  ],)
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