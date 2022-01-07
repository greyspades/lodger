import 'package:flutter/material.dart';
import 'package:lodger/appbar.dart';
void main() {
  runApp(const MyApp());
}

class Top extends StatelessWidget {
  final image;
  final menu;
  const Top({this.image, this.menu});

  @override 
  Widget build(BuildContext context){
    return Container(
      
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {

//   @override 
  
//   _HomePageState createState()=>_HomePageState();
// }




class MyHomePage extends StatelessWidget {
  //_HomePageState({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  String? title;

  bool drawerOpen=false;
  
  void toggleDrawer(){
    drawerOpen=!drawerOpen;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        // appBar:AppBar(
        //   elevation: 0,
        //   toolbarHeight: 200,
        //   leading: Align(alignment: Alignment.topLeft,
          
        //   child:IconButton(icon: Icon(Icons.menu,size: 30,
          
        //    color: const Color(0xffAD714C),),
        //    onPressed: toggleDrawer,
        //    )),
        //   flexibleSpace: Image(
        //     image:const AssetImage('images/background.jpg'), 
        //     fit: BoxFit.cover,
        //   ),
        // ) ,
        // appBar: PreferredSize(preferredSize: Size.fromHeight(200),
        // child: MyAppbar(),
        // ),
        body: Stack(children:<Widget> [
         Container(
           child:  PreferredSize(preferredSize: Size.fromHeight(200),
        child: MyAppbar(),
         ),
         height: 250,
         width: 500,
         ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            color: Color(0xffFBF0EA),
            
            ),
            child: Align(alignment: Alignment.topCenter,
            child: Row(children: [Container(
              decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(10)),color: Colors.grey,),
              height: 80,
              width: 80,
            
              )],
              
              ),
            ),
            width: 292,
            height: 270,
          ) ,
          
          )
           
        ],)
    );
  }
}

