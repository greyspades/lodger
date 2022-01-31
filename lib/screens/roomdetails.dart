import 'package:flutter/material.dart';

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


  RoomDetails({@required this.number,@required this.occupants, @required this.floor, @required this.paid, @required this.status, this.problems,this.icon, this.owing,this.power,this.water });

  @override

  RoomDetailState createState()=>RoomDetailState(paid: paid,problems: problems,owing:owing);
}


class RoomDetailState extends State<RoomDetails>{
  
  bool? paid;
  RoomDetailState({Key? key,this.paid,this.problems,this.owing});

  String? stat;
  IconData? powerIcon;
  IconData? waterIcon;
  IconData? owingIcon;
  IconData? statusIcon;
  List? problems;
  int? owing;
  

  @override 

  Widget build(BuildContext context){

//List? probs=widget.problems;



 if(paid==true){
   stat='Occupied';
 }
 else if (paid==false){
   stat='Available';
 }

// adjusting the power icon
if(widget.power==false){
  powerIcon=Icons.bolt_outlined;
}
else if(widget.power==true){
  powerIcon=Icons.bolt_outlined;
}

//adjusting the water icon
if(widget.water==true){
  waterIcon=Icons.water;
}

else if(widget.water==false){
  waterIcon=Icons.water_outlined;
}

if(widget.status==true){
  statusIcon=Icons.thumb_up;
}

else if(widget.status==false){
  statusIcon=Icons.thumb_down;
}

//Widget debt=Text(widget.owing.toString(),style: TextStyle(fontSize: 30,color: Colors.white),);

//List? probs=widget.problems;

// adjusting the water icon

    return Scaffold(
      backgroundColor: Color(0xffFBF0EA),
      appBar: AppBar(backgroundColor:Color(0xffFB9555),),
      body:Column(
        
        children: [
          //top hero row
          Container(
            //padding: EdgeInsets.all(10),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                child:Hero(child: Icon(widget.icon,color:Color(0xff9F3647),size: 200, ),tag: 'room-hero',),
                //color: Colors.white,
              ),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
               child: Column(children: [
                 Container(
                   child: Text(widget.floor.toString() + widget.number.toString(),style: TextStyle(fontSize: 72)),
                 ),

                Container(
                  child: Row(children: [
                    //Text('Status:${widget.paid ?? 'Occupied' }')
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: Color(0xffFABE99)),
                        //child:Text('Status:Pending', 
                        child: Text('$stat',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
                        ),
                      ),

                      
                  ]),
                ),

                 Row(
                   children: [
                     Container(
                       padding: EdgeInsets.all(5),
                       margin: EdgeInsets.all(10),
                       width: 80,
                       decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(5)),color: Color(0xffFABE99) ),
                   alignment: Alignment.bottomLeft,
                        //child:Text('Status:Pending',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          
                          Text(widget.paid==false ? 'N147000':'Paid',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
                        ),

                          Container(
                        child: widget.paid==true ? Icon(Icons.price_check,color: Color(0xff06B0F9),) : Text(''),
                      )
                        ],)
                      ),

                      
                   ],
                 )
               ],)
              ),

              
            ]),
          ),

          Container(
            height: 70,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),),color: Color(0xffFABE99),),
            margin: EdgeInsets.all(10),
            child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              //power
              Column(
               
                children: [

                Icon(powerIcon,size: 40,color: Color(0xff06B0F9),),
                Text('Power',style: TextStyle(fontWeight: FontWeight.bold))
              ],),

              //water
              Column(
               
                children: [

                Icon(waterIcon,size: 40,color: Color(0xff06B0F9),),
                Text('Water',style: TextStyle(fontWeight: FontWeight.bold))
              ],),

              //debt

                Column(
                children: [

                Icon(Icons.local_atm,size: 40,color: Color(0xff06B0F9),),
                Text('Debt:${widget.owing.toString()}',style: TextStyle(fontWeight: FontWeight.bold,),)
              ],),

              //status
              Column(
                children: [

                Icon(statusIcon,size: 40,color: Color(0xff06B0F9),),
                Text('Status',style: TextStyle(fontWeight: FontWeight.bold),)
              ],),

            ]),
          ),
              
              
          Container(
            height: 340,
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),),color: Color(0xffFABE99),),
            margin: EdgeInsets.all(10),
            alignment:Alignment.center,
            // child: Column(
            //   //children: probs.map((key, value) => null),
            // )
            child:ListView(
              children: problems!.map((e){
                  //return ListTile(title: Text(e),tileColor:Color(0xff9F3647));
                  return Container(child:Text(e,style: TextStyle(color: Colors.white,fontSize: 25),),color: Color(0xff9F3647),margin: EdgeInsets.all(10),padding: EdgeInsets.all(5),height: 40,);
              }).toList()

              
            )
            // child:ElevatedButton(child: Text('probs'),onPressed: (){
            //   print(problems);
            // },)
          )
      ]
      ) ,
      bottomSheet:Container(
        alignment: Alignment.center,
        decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: Color(0xff9F3647) ),
        height: 70,
        width: 500,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(10),
        child: Text('Owe:$owing ',style: TextStyle(fontSize: 30,color: Colors.white),),
      ) ,
    );
  }

}