import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ble_controller.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'char_page.dart';
import 'Inside_auto.dart';

class ModesPage extends StatelessWidget {
  final BluetoothDevice device;

  const ModesPage({Key? key, required this.device}) : super(key: key);
  @override
  Widget build(BuildContext context){
  final BleController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text('MODES'),
      ),
      body: Column(
        children: [Expanded(child: SizedBox(width: double.infinity,
              child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 246, 236, 224),shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero,),
                ),
                onPressed: () {
                  Get.to(()=>InsideAuto(),);
          },
                child: const Text('Auto mode',style: TextStyle(color:Color.fromARGB(255, 51, 1, 72),fontSize: 24,fontWeight: FontWeight.bold,),),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor:const Color.fromARGB(255, 247, 230, 205),shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero,),
                ),
                onPressed:() async {
                   await controller.discoverServices(device);
                if (controller.targetCharacteristic != null) {
                  Get.to(() => ReadWriteCharacteristicsPage(
                        device: device,
                        characteristic: controller.targetCharacteristic!,
                      ));
                }
                },
                child: const Text('Manual Mode',style: TextStyle(color: Color.fromARGB(255, 51, 1, 72),fontSize: 24,fontWeight: FontWeight.bold,),),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 233, 201, 159),shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero,),
                ),
                onPressed: () async {
                   await controller.discoverServices(device);
                if (controller.targetCharacteristic != null) {
                  Get.to(() => ReadWriteCharacteristicsPage(
                        device: device,
                        characteristic: controller.targetCharacteristic!,
                      ));
                }
                },
                child: const Text('Self-check',style: TextStyle(color: Color.fromARGB(255, 51, 1, 72),fontSize: 24,fontWeight: FontWeight.bold,),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
