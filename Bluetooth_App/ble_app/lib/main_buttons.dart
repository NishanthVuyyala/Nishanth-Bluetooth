import 'package:ble_app/inside_selfcheck.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MainButton extends StatelessWidget {
  const MainButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 900,
            width: 600,
            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('https://cdn.prod.website-files.com/5a9ee6416e90d20001b20038/64c15032a90fafad1f5cb935__5.jpg'),
            fit: BoxFit.cover,
              ),
            ),
          ),
          Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white,padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),),
                  onPressed: ()async {
                      Get.to(()=> Insideself());
                  },
                  child: Text('SELF-CHECK',style: TextStyle(color:Color.fromARGB(255, 177, 36, 237)),),
                ),
                SizedBox(height: 20),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white,padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),),
                  onPressed: () {

                  },
                  child: Text('Calibration',style: TextStyle(color:Color.fromARGB(255, 177, 36, 237) ),),
                ),
                SizedBox(height: 20),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white,padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),),
                  onPressed: () {

                  },
                  child: Text('Auto Mode',style: TextStyle(color: Color.fromARGB(255, 177, 36, 237)),),
                ),
                SizedBox(height: 20),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor:Colors.white ,padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),),
                  onPressed: () {},
                  child: Text('Fixed Mode',style: TextStyle(color: Color.fromARGB(255, 177, 36, 237)),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

