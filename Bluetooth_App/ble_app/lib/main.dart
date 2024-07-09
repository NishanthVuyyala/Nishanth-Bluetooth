import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ble_controller.dart';
import 'previous_connection_page.dart';
import 'applications_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BLE SCANNER"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Connection History'),
              onTap: () {
                Get.to(() => const PreviousConnectionsPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.apps),
              title: const Text('Applications'),
              onTap: () {
                Get.to(() => const ApplicationsPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Get.to(() =>const MyHomePage());
              },
            ),
          ],
        ),
      ),
      body: GetBuilder<BleController>(
        init: BleController(),
        builder: (BleController controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Obx(() {
                  if (controller.scanResults.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.scanResults.length,
                        itemBuilder: (context, index) {
                          final data = controller.scanResults[index];
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text(
                                data.device.name.isNotEmpty
                                    ? data.device.name
                                    : 'Unknown Device',
                              ),
                              // subtitle: Text(data.device.id.id),
                              trailing: Text(data.rssi.toString()),
                              onTap: () => controller.connectToDevice(data.device),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("No Device Found"),
                    );
                  }
                }),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    controller.scanDevices();
                  },
                  child: const Text("SCAN"),
                ),
                const SizedBox(height: 20),
                // Obx(() => Text(controller.writeStatus.value)),
              ],
            ),
          );
        },
      ),
    );
  }
}

