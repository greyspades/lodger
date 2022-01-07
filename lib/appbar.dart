import 'dart:html';

import 'package:flutter/material.dart';


class MyAppbar extends StatefulWidget {

  @override 
   _AppbarState createState()=> _AppbarState();
}

class _AppbarState extends State<MyAppbar> {

  bool drawerOpen=false;
  
  void toggleDrawer(){
    drawerOpen=!drawerOpen;
  }

  @override 

  Widget build(BuildContext context){
    return AppBar(
        elevation: 0,
          toolbarHeight: 200,
          leading: Align(alignment: Alignment.topLeft,
          
          child:IconButton(icon: Icon(Icons.menu,size: 30,
          
           color: const Color(0xffAD714C),),
           onPressed: toggleDrawer,
           )),
          flexibleSpace: Image(
            image:const AssetImage('images/background.jpg'), 
            fit: BoxFit.cover,
          ),

          actions: [Align(alignment: Alignment.topRight,
          child: IconButton(icon: Icon(Icons.account_circle,color: Color(0xffAD714C),),onPressed: toggleDrawer,),)],
    );
    
  }
}