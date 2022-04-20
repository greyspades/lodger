import 'package:expandable/expandable.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lodger/components/avatar.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class Item  {
  bool? expanded;
  List? dataList;
  Map<String, dynamic>? data;
  DocumentSnapshot? info;
  Item({this.data,this.info,this.snapshot,this.expanded,this.dataList});

void _setExpand(){
  expanded=true;
}


  AsyncSnapshot? snapshot;

}




class Notifications extends StatefulWidget {

  Stream<QuerySnapshot>? mailStream;

  Notifications({@required this.mailStream });

  @override
  _NotificationState  createState()=> _NotificationState();
}

class _NotificationState extends State<Notifications> {

  //double panelHeight=_expandableController.expanded ? 100 : 200;
  //bool raisedPanel=false;
  //double panelHeight=_expandableController.value ? 470 :100;

List<Item> generateItems(int numberOfItems,  data) {

  return List<Item>.generate(numberOfItems, (int index) {
     Map<String, dynamic> messages={};
    // Map<String, dynamic> messages=data.map((item){
    //   return item as Map<String, dynamic>;
    // });
    data.forEach((item){messages['subject']=item['subject']; messages['sender']=item['sender'];});
    // Map<String, dynamic> messages=data.map((item)=>{
    //   'subject':item['subject'],
    // });
     //Map<String, dynamic> messages=Map.fromIterable(data,key: (item)=>item[])

    return Item(
      
      data: messages,
      dataList:data
    );
  });
}

    

  Widget expansionPanel(AsyncSnapshot snapshot){
    ExpandableController? expandControler;

    return Stack(
      children:snapshot.data!.docs.map<Widget>((DocumentSnapshot document){
         Map<String, dynamic> doc=document.data() as Map<String, dynamic>;
       
          //  var items=doc['mail'].map((item){
          //    //print(item);
          //    Map<String, dynamic> message=item;
          //   return Item(
          //     data: item,
          //     expanded: false
          //   );
          //   //return item;
          //     }).toList();

              return Container(
                color: Colors.deepPurpleAccent,
                height: doc['mail'].length>1 ? 300 : 200,
                child: ListView(
                children: doc['mail'].map<Widget>((d){
                  //var time=DateTime.fromMillisecondsSinceEpoch(d['time'].toDate());

                  var formatedTime=DateFormat.yMMMd().format(d['time'].toDate());
                  //String priority=d['']

                  return Container(
                    color:Color(0xffFBF0EA),
                      margin: EdgeInsets.only(left: 5,right: 5,bottom: 5,top: 5),

                    //*expandable widget for notifications
                    child: ExpandablePanel(
                      controller: expandControler,
                      collapsed: Container(
                    color:Color(0xff9F3647) ,
                  
                   
                  ), expanded: Container(

                    color:Color(0xff9F3647),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                       //*row for the sender details of the mail
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(formatedTime,style: TextStyle(color: Colors.white),),
                       Text('from: ${d['sender']}',style: TextStyle(color: Colors.white),),
                       Text('priority: ${d['critical'] ? 'High' : 'Low'}',style: TextStyle(color: Colors.white),),
                       ], 
                       ),
                     
                        //* notification body
                       Row(children: [
                         Container(
                           width: 360,
                           margin: EdgeInsets.only(top: 30,bottom: 5),
                           child:  Text(d['item'],style: TextStyle(color: Colors.white),),
                         )
                       ],),

                    ],)
                    ),

                    //*header for the expanson panel
                    header: Container(
                      
                      margin: EdgeInsets.only(left: 5,right: 5,top:5,bottom: 5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: Color(0xffFBF0EA),),
                      child: ListTile(title: Text(d['subject']),leading: CircleAvatar(),focusColor:Color(0xffFBF0EA),onTap: (){
                        print(expandControler?.expanded);
                      },)
                    ),
                    ),
                  );
                }).toList(),
              ),
              );

              
          
          
          
         }).toList() ,
    );

       
      
  }

  
  @override 

  Widget build(BuildContext context){

    bool expand=false;

    ExpandableController _expandableController=ExpandableController(initialExpanded: expand);
  
    double panelHeight=_expandableController.value ? 470 :100;
    //print(_expandableController.value);

    

    return Container(
      //height: panelHeight,
      //color: Colors.pink,
      child: StreamBuilder(
              stream:widget.mailStream,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot ){
                if (snapshot.hasError) {
          return Text("Something went wrong");
        }

                if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        } 

      return SingleChildScrollView(
        child: Container(
          child: expansionPanel(snapshot),
        ),
      );

    ;




    
        //);
              },
              



              
            )
  
    );
    
    }
}