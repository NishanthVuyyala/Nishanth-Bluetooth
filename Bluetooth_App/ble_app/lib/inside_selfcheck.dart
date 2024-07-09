import 'package:ble_app/main_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Insideself extends StatelessWidget {
  const Insideself({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text('SELF-CHECK'),),
    body: Center(child:Column(mainAxisAlignment: MainAxisAlignment.center,children: [ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 233, 177, 105),padding: EdgeInsets.all(25)),
      onPressed:() {
      
    },
    child: Text('CHECK',style: TextStyle(color: const Color.fromARGB(255, 65, 3, 76) ),
    )
    ),
SizedBox(height: 30.0),
ElevatedButton( style:ElevatedButton.styleFrom(backgroundColor: Colors.purple ) ,
onPressed:() async{
  Get.to(()=> MainButton());

}, child:Text('completed',style: TextStyle(color: Colors.black),) )
    ],) 
    
    ), 
    ) ;
  }
}