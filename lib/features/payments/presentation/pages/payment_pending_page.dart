import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/payment_status.dart';
import '../../domain/entities/payment_method.dart';
import '../controllers/payment_controller.dart';
import '../../../../core/routes/app_routes.dart';

class PaymentPendingPage extends GetView<PaymentController> {
  const PaymentPendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Payment')),
      body: Obx(() {
        final intent = controller.intent.value;
        if (intent == null) {
          return const Center(child: Text('No payment'));
        }
        final widgets = <Widget>[
          Text('Amount: ${intent.amount}'),
        ];
        switch (intent.method.channel) {
          case PaymentChannel.va:
            widgets.add(Text('VA Number: ${intent.vaNumber}'));
            break;
          case PaymentChannel.ewallet:
          case PaymentChannel.card:
            widgets.add(Text('Redirect: ${intent.redirectUrl}'));
            break;
          case PaymentChannel.qris:
            widgets.add(Text('QRIS: ${intent.qrisPayload}'));
            break;
        }
        widgets.add(const SizedBox(height: 24));
        widgets.add(ElevatedButton(
          onPressed: () async {
            await controller.pollUntilDone();
            if (controller.status.value == PaymentStatus.paid) {
              Get.offAllNamed(AppRoutes.bookingSuccess);
            }
          },
          child: const Text('I have paid'),
        ));
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          ),
        );
      }),
    );
  }
}
