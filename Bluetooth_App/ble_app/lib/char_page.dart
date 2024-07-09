import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'ble_controller.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ReadWriteCharacteristicsPage extends StatelessWidget {
  final BluetoothDevice device;
  final BluetoothCharacteristic characteristic;

  const ReadWriteCharacteristicsPage({
    Key? key,
    required this.device,
    required this.characteristic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BleController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(device.name.isNotEmpty ? device.name : 'Unknown Device'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("Device ID: ${device.id.id}"),
            // Text("Characteristic: ${characteristic.uuid}"),
            // const SizedBox(height: 20),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 233, 177, 105),),
              onPressed: () async {
                await controller.writeToCharacteristic("BESQUARE");
              },
              child: const Text("Write"),
            ),
            const SizedBox(height: 20),
            ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 233, 177, 105),),
              onPressed: () async {
                await controller.readFromCharacteristic(characteristic);
              },
              child: const Text("Read"),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(controller.writeStatus.value)),
          const SizedBox(height: 20),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 233, 177, 105),),
          onPressed:() async{
            await controller.readFromCharacteristic(characteristic);
          },
          child: const Text('Disconnect'),          
          )
          ],
        ),
      ),
    );
  }
}
