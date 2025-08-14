import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/speedboat_controller.dart';

/// Displays booking success information.
class BookingSuccessPage extends GetView<SpeedboatController> {
  const BookingSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = controller.booking.value;
    return Scaffold(
      appBar: AppBar(title: const Text('Success')),
      body: Center(
        child: booking == null
            ? const Text('No booking')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Booking: ${booking.id}'),
                  Text('Seats: ${booking.heldSeatIds?.join(', ')}'),
                ],
              ),
      ),
    );
  }
}
