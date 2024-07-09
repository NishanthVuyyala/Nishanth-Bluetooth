import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsideAuto extends StatelessWidget {
  const InsideAuto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text("CHECK PAGE"),
      ),
      body: Center(
        child: ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 233, 177, 105),padding: EdgeInsets.all(50.0)),
         onPressed:(){
          print('checking');
        },
        child: const Text('CHECK',style:TextStyle(fontWeight: FontWeight.bold,fontSize: Checkbox.width),),
        ),
      ),
    );
  }
}

