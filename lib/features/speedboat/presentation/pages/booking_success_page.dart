import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/speedboat_controller.dart';
import '../../../payments/presentation/controllers/payment_controller.dart';

/// Displays booking success information.
class BookingSuccessPage extends GetView<SpeedboatController> {
  const BookingSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = controller.booking.value;
    final paymentCtrl = Get.find<PaymentController>();
    final intent = paymentCtrl.intent.value;
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
                  if (intent != null) ...[
                    const SizedBox(height: 8),
                    Text('Payment: ${intent.id}'),
                    Text('Status: ${paymentCtrl.status.value.name}'),
                  ],
                ],
              ),
      ),
    );
  }
}
