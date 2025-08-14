import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/speedboat_controller.dart';
import '../widgets/seat_grid.dart';
import '../../../../core/utils/formatters.dart';

/// Page for selecting seats on a regular schedule.
class SeatMapPage extends GetView<SpeedboatController> {
  const SeatMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Seats')),
      body: Obx(() {
        final seats = controller.seatMap;
        if (seats.isEmpty) {
          return const Center(child: Text('No seats available'));
        }
        return Column(
          children: [
            Expanded(
              child: SeatGrid(
                seats: seats,
                selectedSeatIds: controller.selectedSeatIds.toSet(),
                onTap: controller.toggleSeat,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Obx(() => Text(
                    'Total: ' +
                        formatCurrency(controller.totalPrice),
                  )),
            ),
          ],
        );
      }),
    );
  }
}
