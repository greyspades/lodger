import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({ Key? key }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
 final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15,bottom: 10),
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(left:20,top: 120),
      width: 330,
      height: 50,
      decoration:BoxDecoration(color: Color(0xffFBF0EA),borderRadius: BorderRadius.all(Radius.circular(30)),border:Border.all(color: Color(0xff9F3647),width: 2)),
      child: Container(
          
          //width: 270,
          
          child:TextField(
            //showCursor: false,
            controller: myController,
            cursorColor: Color(0xff9F3647),
            cursorHeight: 25,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              focusedBorder: InputBorder.none,
                 enabledBorder: InputBorder.none,
                 ///label: Text('Lodge'),
                hintText: 'Search for a lodge',
              border: null,
              suffixIconColor: Colors.blue,
              suffixIcon:IconButton(icon: Icon(Icons.search,size: 35, color: Color(0xff9F3647),),onPressed: (){print(myController.text);},color: Colors.red,),
            //labelText: 'Password',
          ),

           
          ),
         
        ),
    );
  }
}

// class SearchBar extends StatelessWidget {
//   SearchBar({ Key? key }) : super(key: key);
  
// }