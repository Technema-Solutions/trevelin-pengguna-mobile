import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/speedboat_controller.dart';

/// Shows details of a selected schedule.
class SpeedboatDetailPage extends GetView<SpeedboatController> {
  const SpeedboatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final schedule = controller.selectedSchedule.value;
    if (schedule == null) {
      return const Scaffold(body: Center(child: Text('No schedule')));
    }
    return Scaffold(
      appBar: AppBar(title: Text('${schedule.routeFrom} → ${schedule.routeTo}')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            controller.loadSeatMap(schedule.id);
            Get.toNamed('/speedboat/${schedule.id}/seat-map');
          },
          child: const Text('Select Seats'),
        ),
      ),
    );
  }
}
