//import 'dart:html';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:lodger/screens/login.dart';
import 'package:mongo_dart/mongo_dart.dart'  show Db, DbCollection;
import 'package:path/path.dart';
import 'package:lodger/screens/login.dart';
import 'package:lodger/screens/roominfo.dart';


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
    //Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
  }

  @override 

  Widget build(BuildContext context){
    return AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(100))),
        elevation: 0,
          //toolbarHeight: 200,
          leading: Align(alignment: Alignment.topLeft,
          
          child:IconButton(icon: Icon(Icons.menu,size: 40,
          
           color: Color(0xff9F3647),),
           onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Info()));
           },
           
           )),
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(80)),
            child: Image(
           // height: 500,
            image:const AssetImage('images/background.jpg'), 
            fit: BoxFit.cover,
          ),),

          actions: [Align(alignment: Alignment.topRight,
          child: IconButton(icon: Icon(Icons.account_circle,color:Color(0xff9F3647),size: 40,),onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
          
          },),)],
    );
    
  }
}