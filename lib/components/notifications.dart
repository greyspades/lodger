import 'package:expandable/expandable.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lodger/components/avatar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';


class Item  {
  bool expanded;
  Map<String, dynamic>? data;
  DocumentSnapshot? info;
  Item({this.data,this.info,this.snapshot,this.expanded=false});

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

    

  Widget expansionPanel(AsyncSnapshot snapshot){

    return Stack(
      children:snapshot.data!.docs.map<Widget>((DocumentSnapshot document){
         Map<String, dynamic> data=document.data() as Map<String, dynamic>;
         Item first=new Item(data: data);
            return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded){
       
        setState(() {
          first.expanded=true;
        });
      },
      children: first.data?['mail'].map<ExpansionPanel>((d){
        //Map<String, dynamic> data=document.data() as Map<String, dynamic>;
         //Item item=new Item(data: data);
         Item mail=new Item(data: d);
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded){
            
          return Container(
                              child: ListTile(
                      // onTap: (){
                      //   print('tapped');
                      //    setState(() {
                      //      mail.expanded=true;
                      //    });
                      // },
                      leading: Container(child: CircleAvatar(),),
                      title: Text(mail.data?['subject']),
                      tileColor:Color(0xffFBF0EA) ,
                      
                   
                    )
          );
        }, body: Container(
          child: Text(mail.data?['subject']),
        ),
        isExpanded: mail.expanded 
        //isExpanded: true
        );
      }).toList()
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

    if(_expandableController.value==true){
      print('expanded');
    }

    else if(_expandableController.value==false){
      print('not expanded');
    }

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

    // return ExpansionPanelList(
    //   children: snapshot.data!.docs.map((DocumentSnapshot document){
    //      //Map<String, dynamic> data=document.data() as Map<String, dynamic>;
         
    //     return ExpansionPanel(headerBuilder: (BuildContext context, bool isExpanded){
    //       return Container();
    //     }, body: Container());
    //   }).toList()

    // );




    //     return ListView(
    //       children: snapshot.data!.docs.map((DocumentSnapshot document){
    //         Map<String, dynamic> data=document.data() as Map<String, dynamic>;
           
    //  return Stack(
    //       children: data['mail'].map<Widget>((d){
    //             return Container(
                  
    //             color: Color(0xff9F3647),
    //               margin: EdgeInsets.all(3),
    //               child: !d['read'] ? ExpandableNotifier(

    //                 controller: _expandableController,
    //                 child: ExpandablePanel(
    //                 // builder: ((context, collapsed, expanded,) {
    //                 //   return Container(
    //                 //     // height: 200,
    //                 //     // color: Colors.white,
    //                 //     child: ExpandablePanel(collapsed: collapsed,expanded:expanded,)
    //                 //   );
                      
    //                 // }),
    //                 controller: _expandableController,
                    

    //                 header: Container(
                      
    //                   color: Color(0xffFBF0EA) ,

                      
    //                   child: ListTile(
    //                     onTap: (){
    //                      // _expandableController.expanded;
    //                       setState(() {
    //                        //_expandableController.expanded=true;
    //                        expand=true;
    //                       });
                          
    //                     print(expand);
    //                      },
    //                   leading: Container(child: CircleAvatar(),),
    //                   title: Text(d['subject']),
    //                   tileColor:Color(0xffFBF0EA) ,
                   
    //                 ),
                    
    //                 ),
    //                 expanded: Container(
    //                   padding: EdgeInsets.only(left: 10,right: 10,top: 5),
    //                   height: 130,

    //                   decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(3),bottomLeft: Radius.circular(3),bottomRight: Radius.circular(3))),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           children: [
    //                           Text("From",style:TextStyle(color: Colors.white)),

    //                           //sender of mail

    //                           Container(
    //                             margin: EdgeInsets.only(left: 5,right: 25),
    //                             child: Chip(
                                  
    //                               //backgroundColor:Color(0xffFBF0EA),
    //                               label: Text(d['sender']),
    //                              ),
    //                           ),

    //                           //urgency
    //                           Row(children: [
    //                             Text('Priority',style: TextStyle(color: Colors.white),),
    //                             Container(
    //                               margin: EdgeInsets.only(left: 5),
    //                               child: Chip(label: Text(d['critical'] ? 'Major':'Minor',style: TextStyle(),)),
    //                             )
    //                             //Icon(icon:d['critical'] ? :Icons.)
    //                           ],),

                             
                             
    //                         ],
    //                         ),
                            
    //                        Container(
    //                          margin: EdgeInsets.only(top: 23),
    //                          child:  Text(d['item'],style: TextStyle(color: Colors.white),),
    //                        ),

    //                        //button to mark as read
    //                       Container(
    //                         margin: EdgeInsets.only(top:20),
    //                         child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                         Text(d['time'].toDate().toString(),style: TextStyle(color: Colors.white),),


    //                         //inner row to mark as read
    //                         Row(children: [
    //                           Text('mark read',style: TextStyle(color: Colors.white),),
    //                           Checkbox(value: d['read'], onChanged: (bool? changed){
                                
    //                         },)
    //                         ],)
    //                       ],),
    //                       ),

    //                       //bottom card menu
                          
                        
    //                   ]),
                      
    //                 ),

    //                 collapsed: Container(
    //                   // height: 150,
    //                   // width: 360,
    //                   // color: Colors.blue,
    //                   // child: Text(d['subject']),
    //                 ),
    //               ))
    //               :
    //               Container(),
    //             );
    //           }).toList()
    //   );
    


    //         // );
    //       }).toList(),
        //);
              },
              



              
            )
  
    );
    
    }
}