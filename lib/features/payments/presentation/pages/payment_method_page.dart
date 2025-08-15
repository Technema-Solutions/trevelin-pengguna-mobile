import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/payment_controller.dart';
import '../widgets/payment_channel_picker.dart';
import '../../../speedboat/presentation/controllers/speedboat_controller.dart';
import '../../../../core/routes/app_routes.dart';

class PaymentMethodPage extends GetView<PaymentController> {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sb = Get.find<SpeedboatController>();
    final booking = sb.booking.value;
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Method')),
      body: booking == null
          ? const Center(child: Text('No booking'))
          : Column(
              children: [
                PaymentChannelPicker(
                  onSelected: controller.chooseMethod,
                ),
                const Spacer(),
                Obx(() => ElevatedButton(
                      onPressed: controller.selected.value == null
                          ? null
                          : () async {
                              await controller.createAndStart(
                                bookingId: booking.id,
                                amount: booking.amount,
                              );
                              Get.toNamed(AppRoutes.paymentPending);
                            },
                      child: const Text('Continue'),
                    )),
                const SizedBox(height: 16),
              ],
            ),
    );
  }
}
