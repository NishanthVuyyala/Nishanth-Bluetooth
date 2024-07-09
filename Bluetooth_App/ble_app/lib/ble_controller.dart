import 'package:ble_app/main.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'device_details_page.dart';

class BleController extends GetxController {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  RxList<ScanResult> scanResults = <ScanResult>[].obs;
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? targetCharacteristic;
  RxString writeStatus = 'Not written yet'.obs;

  final DatabaseHelper dbHelper = DatabaseHelper();

  @override   
  void onInit() {
    super.onInit();
    flutterBlue.state.listen((state) {
      if (state == BluetoothState.on) {
        scanDevices();
      }
    });
  }

  void scanDevices() {
    scanResults.clear();
    flutterBlue.startScan(timeout: const Duration(seconds: 5));

    flutterBlue.scanResults.listen((results) {
      scanResults.clear();
      scanResults.addAll(results);
    }).onDone(() {
      flutterBlue.stopScan();
      update();
    });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    if (connectedDevice != null && connectedDevice!.id == device.id) {
      // Device is already connected, navigate to DeviceDetailsPage
      Get.to(() => DeviceDetailsPage(device: device));
      return;
    }

    try {
      await device.connect();
      connectedDevice = device;
      writeStatus.value = 'Connected to ${device.name}';
      print('Connected to ${device.name}');
      Get.to(() => DeviceDetailsPage(device: device));

      Map<String, dynamic> row = {
        'deviceId': device.id.id,
        'deviceName': device.name,
        'timestamp': DateTime.now().toIso8601String()
      };
      await dbHelper.insertConnection(row);
    } catch (e) {
      writeStatus.value = 'Connection failed: $e';
      print('Connection failed: $e');
    }
    update();
  }

  Future<void> discoverServices(BluetoothDevice device) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.properties.write && characteristic.properties.read) {
            targetCharacteristic = characteristic;
            writeStatus.value = 'Found writable and readable characteristic';
            print('Found writable and readable characteristic: ${characteristic.uuid}');
            return;
          }
        }
      }
      if (targetCharacteristic == null) {
        writeStatus.value = 'No writable and readable characteristic found';
        print('No writable and readable characteristic found');
      }
    } catch (e) {
      writeStatus.value = 'Service discovery failed: $e';
      print('Service discovery failed: $e');
    }
    update();
  }

  Future<void> writeToCharacteristic(String dataToSend) async {
    if (targetCharacteristic != null) {
      try {
        List<int> bytes = dataToSend.codeUnits;
        await targetCharacteristic!.write(bytes);
        writeStatus.value = "Data sent: $dataToSend";
        print("Data sent: $dataToSend");

        // Optionally, read back the value to verify
        await readFromCharacteristic(targetCharacteristic!);
      } catch (e) {
        writeStatus.value = 'Failed to send data: $e';
        print('Failed to send data: $e');
      }
    } else {
      writeStatus.value = 'No writable characteristic selected';
      print('No writable characteristic selected');
    }
    update();
  }

  Future<void> readFromCharacteristic(BluetoothCharacteristic characteristic) async {
    try {
      List<int> value = await characteristic.read();
      String receivedData = String.fromCharCodes(value);
      if (receivedData == "BESQUARE") {
        writeStatus.value = "Read value: $receivedData";
        print("Read value: $receivedData");
      } else {
        writeStatus.value = "Unexpected value: $receivedData";
        print("Unexpected value: $receivedData");
      }
    } catch (e) {
      writeStatus.value = 'Failed to read data: $e';
      print('Failed to read data: $e');
    }
    update();
  }

  Future<void> disconnectToDevice(BluetoothDevice device) async {
    try {
      await device.disconnect();
      connectedDevice = null;
      writeStatus.value = 'Disconnected from ${device.name}';
      print('Disconnected from ${device.name}');
      Get.to(() => MyHomePage()); 
    } catch (e) {
      writeStatus.value = 'Disconnection failed: $e';
      print('Disconnection failed: $e');
    }
    update(); 
  }

  Future<List<Map<String, dynamic>>> getPreviousConnections() async {
    return await dbHelper.queryAllConnections();
  }
}