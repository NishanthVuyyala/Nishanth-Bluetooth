import 'package:ble_app/main_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ble_controller.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceDetailsPage extends StatelessWidget {
  final BluetoothDevice device;

  const DeviceDetailsPage({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BleController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(device.name.isNotEmpty ? device.name : 'Unknown Device'),
        actions: [IconButton(icon: Icon(Icons.info),
            onPressed: () {
              showDialog(context: context,builder: (context) => AlertDialog(title: Text('Device ID'),
                  content: Text(device.id.id),
                  // actions: [
                  //   TextButton(
                  //     onPressed: () => Get.back(),
                  //     child: Text('OK'),
                  //   ),
                  // ],
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 51, 1, 72),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   "Device ID: ${device.id.id}",
              //   style: TextStyle(color: Colors.white),
              // ),
              Obx(() => Text(
                "Status: ${controller.writeStatus.value}",
                style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 18.0),
              )),
              SizedBox(height: 20,),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed:()async {
                // await controller.discoverServices(device);
                // if (controller.targetCharacteristic != null) {
                  Get.to(() =>MainButton());
                // }
              }, child: Text('NEXT',style: TextStyle(color: Colors.purple,))),
            ],
          ),
        ),
      ),
    );
  }
}
