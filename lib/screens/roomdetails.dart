import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomDetails extends StatefulWidget {
  int? number;
  List? occupants;
  List? problems;
  bool? status;
  String? floor;
  bool? paid;
  IconData? icon;
  bool? water;
  bool? power;
  int? owing;
  bool? user;
  String? room;
  String? id;

  RoomDetails(
      {@required this.number,
      @required this.occupants,
      @required this.floor,
      @required this.paid,
      @required this.status,
      this.problems,
      this.icon,
      this.owing,
      this.power,
      this.water,
      this.user,
      this.room,
      this.id,
      });

  @override
  RoomDetailState createState() => RoomDetailState(
      paid: paid,
      problems: problems,
      owing: owing,
      user: user,
      occupants: occupants);
}

class RoomDetailState extends State<RoomDetails> {
  bool? paid;
  RoomDetailState(
      {Key? key,
      this.paid,
      this.problems,
      this.owing,
      this.user,
      this.occupants,
      this.id
      });

  String? stat;
  IconData? powerIcon;
  IconData? waterIcon;
  IconData? owingIcon;
  IconData? statusIcon;
  List? problems;
  int? owing;
  bool? user;
  List? occupants;
  String? id;
  
// check if the resolve button is clicked
  bool resolving =false;
  bool resolved =true;

  bool showProblemMenu = false;

//Widget bottom=Scaffold.bottomSheet;

CollectionReference users=FirebaseFirestore.instance.collection('users');

  CollectionReference rooms=FirebaseFirestore.instance.collection('rooms');

  showReport(){
    return SimpleDialog(
      title: Text('Report a new problem'),
      backgroundColor:Color(0xffFABE99),
      contentPadding: EdgeInsets.all(10),
      elevation: 10,
      children: [
        TextField(
          
        )
      ],
    );
  }

  resolveProblem(){
    print('');
    // setState(() {
    //   resolving=true;
    //   resolved=false;
    // });
    // users.doc(id).update({'problems[0]':null}).then((res){
    //   print('updated');
    // });


  }


   _showModalBottomSheet()
  {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            //decoration: BoxDecoration(color: Colors.brown,borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            width: double.infinity,
            color: Color(0xffFABE99),
            alignment: Alignment.center,
            child: Column(children: [
              Text('Enter new problem',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              
              Container(
                height: 150,
                  child: TextFormField(decoration: InputDecoration(border:OutlineInputBorder(),
                 
                 ),
                 style: TextStyle(),
                 )
              )
            ],)
          );
        });}


  @override
  Widget build(BuildContext context) {


    if (paid == true) {
      stat = 'Occupied';
    } else if (paid == false) {
      stat = 'Available';
    }

// adjusting the power icon
    if (widget.power == false) {
      powerIcon = Icons.bolt_outlined;
    } else if (widget.power == true) {
      powerIcon = Icons.bolt_outlined;
    }

//adjusting the water icon
    if (widget.water == true) {
      waterIcon = Icons.water;
    } else if (widget.water == false) {
      waterIcon = Icons.water_outlined;
    }

    if (widget.status == true) {
      statusIcon = Icons.thumb_up;
    } else if (widget.status == false) {
      statusIcon = Icons.thumb_down;
    }

//Widget debt=Text(widget.owing.toString(),style: TextStyle(fontSize: 30,color: Colors.white),);

//List? probs=widget.problems;

// adjusting the water icon

    return Scaffold(
      backgroundColor: Color(0xffFBF0EA),
      appBar: AppBar(
        backgroundColor: Color(0xff9F3647),
      ),
      body: Column(children: [
        //top hero row
        Container(
          //padding: EdgeInsets.all(10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              child: Hero(
                child: Icon(
                  widget.icon,
                  color: Color(0xff9F3647),
                  size: 200,
                ),
                tag: 'room-hero',
              ),
              //color: Colors.white,
            ),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                          widget.floor.toString() + widget.number.toString(),
                          style: TextStyle(fontSize: 72)),
                    ),
                    Container(
                      child: Row(children: [
                        //Text('Status:${widget.paid ?? 'Occupied' }')
                        Container(
                          width: 100,
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xffFABE99)),
                          //child:Text('Status:Pending',
                          child: Text('$stat',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ]),
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(10),
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Color(0xffFABE99)),
                            //alignment: Alignment.bottomLeft,
                            //child:Text('Status:Pending',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.paid == false ? 'N147000' : 'Paid',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  child: widget.paid == true
                                      ? Icon(
                                          Icons.price_check,
                                          color: Color(0xff06B0F9),
                                        )
                                      : Text(''),
                                )
                              ],
                            )),
                      ],
                    )
                  ],
                )),
          ]),
        ),
        //   Container(
        //   child: user! ? ListView(
        //     scrollDirection: Axis.horizontal,

        //     children:occupants!.map((e){
        //         return ListTile(
        //       title: Text(e),
        //     );
        //   }).toList()): Text('no access')
        // ),
        Container(
            //color: Colors.blue,
            height: 50,
            //margin: EdgeInsets.all(20),
            child: (user ?? false)
                ? ListView(
                    scrollDirection: Axis.horizontal,
                    children: occupants!.map((e) {
                      return Container(
                        alignment: Alignment.center,
                        width: 100,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xff9F3647),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          e,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      );
                    }).toList())
                : null),

        Container(
          height: 60,
          padding: EdgeInsets.only(left: 30, right: 30, top: 3, bottom: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(46),
            ),
            color: Color(0xffFABE99),
          ),
          margin: EdgeInsets.all(5),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //power
            Column(
              children: [
                Icon(
                  powerIcon,
                  size: 35,
                  color: Color(0xff06B0F9),
                ),
                Text('Power', style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),

            //water
            Column(
              children: [
                Icon(
                  waterIcon,
                  size: 35,
                  color: Color(0xff06B0F9),
                ),
                Text('Water', style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),

            //debt

            Column(
              children: [
                Icon(
                  Icons.local_atm,
                  size: 35,
                  color: Color(0xff06B0F9),
                ),
                Text(
                  'Debt:${widget.owing.toString()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),

            //status
            Column(
              children: [
                Icon(
                  statusIcon,
                  size: 35,
                  color: Color(0xff06B0F9),
                ),
                Text(
                  'Status',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ]),
        ),

        Container(
            height: 340,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              color: Color(0xffFABE99),
            ),
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            // child: Column(
            //   //children: probs.map((key, value) => null),
            // )
            child: ListView(
                children: problems!.map((e) {
              //return ListTile(title: Text(e),tileColor:Color(0xff9F3647));
              return Container(
                alignment: Alignment.center,
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xff9F3647),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                  e,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
               
               !resolving && resolved ?

                ElevatedButton(onPressed: (){resolveProblem();}, child: Text('mark'),style: ElevatedButton.styleFrom(
                  //primary: Color(0xffFB9555),
                  
                  shape: new RoundedRectangleBorder(
      borderRadius: new BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
    ),))

        :
        resolving && !resolved ?

        CircularProgressIndicator()

        :

        !resolving && resolved ?

        Icon(Icons.check)

        :

        Text('')

                  ],
                ),
                margin: EdgeInsets.all(10),
                height: 40,
              );
            }).toList())
            // child:ElevatedButton(child: Text('probs'),onPressed: (){
            //   print(problems);
            // },)
            ),
            

    //        Container(
    //          height: 200,
    //          width: 200,
    //          child:  SimpleDialog(
              
    //   title: Text('Report a new problem'),
    //   backgroundColor:Color(0xffFABE99),
    //   contentPadding: EdgeInsets.all(10),
    //   elevation: 10,
    //   children: [
    //     TextField(
          
    //     )
    //   ],
    // ),
    //        ),

            showProblemMenu ? 

            SimpleDialog(
      title: Text('Report a new problem'),
      backgroundColor:Color(0xffFABE99),
      contentPadding: EdgeInsets.all(10),
      elevation: 10,
      children: [
        TextField(
          
        )
      ],
    )
    :

    Container(
                child: ElevatedButton(
                  child: Text('Report problem'),
                  onPressed: () {
                    setState(() {
                      _showModalBottomSheet();
                      //showProblemMenu=true;
                      //Scaffold.showBottomSheet;
                    });
                  },
                ),
              ),

        // (user ?? false)
        //     ? Container(
        //         child: ElevatedButton(
        //           child: Text('Report problem'),
        //           onPressed: () {},
        //         ),
        //       )
        //     : Text(''),
      ]),
      // bottomSheet: Container(
      //   alignment: Alignment.center,
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.all(Radius.circular(5)),
      //       color: Color(0xff9F3647)),
      //   height: 70,
      //   width: 500,
      //   padding: EdgeInsets.all(5),
      //   margin: EdgeInsets.all(10),
      //   child: Text(
      //     'Owe:$owing ',
      //     style: TextStyle(fontSize: 30, color: Colors.white),
      //   ),
      // ),
      // bottomSheet: BottomSheet(onClosing: (){
        
      // },
      // builder:(BuildContext context)=>Container(
      //   child: Text('the fallen shall rise again'),
      // ),

      // ),
    );
  }
}
