import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ble_controller.dart';

class PreviousConnectionsPage extends StatelessWidget {
  const PreviousConnectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BleController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Connections history"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: controller.getPreviousConnections(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Previous Connections"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final connection = snapshot.data![index];
                return ListTile(
                  title: Text(connection['deviceName'] ?? 'Unknown Device'),
                  subtitle: Text(connection['deviceId']),
                  trailing: Text(connection['timestamp']),
                );
              },
            );
          }
        },
      ),
    );
  }
}