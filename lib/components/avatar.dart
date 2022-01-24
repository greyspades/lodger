import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {

  final name;
  final int? room;
  final  image;

  Avatar({Key? key, required this.name, this.room, this.image});

  void handle(){
    print('seen details');
  }

  @override 
  Widget build(BuildContext context){

    return Container(
      margin: const EdgeInsets.only(left: 17,right: 17),
      //color: Colors.red,
      height: 120,
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

        //user image

          Container(
          width: 100,
          height: 100,
          //color: Colors.red,
          child:IconButton(onPressed: handle, icon: const Icon(Icons.face,size:90),),
          
        ),

      //user name
       
       Flexible(flex: 2, child:  Text(name,
       textAlign: TextAlign.center,style: const TextStyle(decoration:TextDecoration.none ),),)
      

      ],)
    );

  }
}