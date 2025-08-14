import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../speedboat/presentation/controllers/speedboat_controller.dart';

/// Displays list of speedboat schedules.
class SpeedboatListPage extends GetView<SpeedboatController> {
  const SpeedboatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Speedboat')),
      body: Obx(() {
        final schedules = controller.schedules;
        if (schedules.isEmpty) {
          controller.loadSchedules();
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: schedules.length,
          itemBuilder: (context, index) {
            final s = schedules[index];
            return ListTile(
              title: Text('${s.routeFrom} → ${s.routeTo}'),
              subtitle: Text(s.serviceType.name),
              onTap: () {
                controller.selectedSchedule.value = s;
                Get.toNamed('/speedboat/${s.id}');
              },
            );
          },
        );
      }),
    );
  }
}
