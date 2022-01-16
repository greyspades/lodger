import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {

  final name;
  final String? room;
  final  image;

  Avatar({Key? key, required this.name, this.room, this.image});

  void handle(){
    print('seen details');
  }

  @override 
  Widget build(BuildContext context){
    return Padding(padding: EdgeInsets.all(20),
    child: Container(
      margin: EdgeInsets.all(10),
      color: Colors.blue,
      child:Column(children: [
       Center(child:  IconButton(onPressed: handle, icon: Icon(Icons.face,size: 60,)),),
        Text(name)
      ],
      //mainAxisAlignment: MainAxisAlignment.center,
      ) ,
      
    )
    );
  }
}