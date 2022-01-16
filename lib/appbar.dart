import 'dart:html';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart'  show Db, DbCollection;


class MyAppbar extends StatefulWidget {
  // final Db? get;
  // MyAppbar({this.get});

  @override 
   _AppbarState createState()=> _AppbarState();
}

class _AppbarState extends State<MyAppbar> {

  bool drawerOpen=false;
  
   toggleDrawer(){
    //drawerOpen=!drawerOpen;
    //developer.log('ludex gundyr');
    print('ludex gundyr');
  }

  @override 

  Widget build(BuildContext context){
    return AppBar(
        elevation: 0,
          toolbarHeight: 200,
          leading: Align(alignment: Alignment.topLeft,
          
          child:IconButton(icon: Icon(Icons.menu,size: 30,
          
           color: const Color(0xffAD714C),),
           onPressed: toggleDrawer(),
           
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