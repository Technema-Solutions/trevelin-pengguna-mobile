import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/speedboat_controller.dart';
import '../../../../core/routes/app_routes.dart';

/// Checkout page collecting user info and confirming booking.
class BookingCheckoutPage extends StatefulWidget {
  const BookingCheckoutPage({super.key});

  @override
  State<BookingCheckoutPage> createState() => _BookingCheckoutPageState();
}

class _BookingCheckoutPageState extends State<BookingCheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _contactCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpeedboatController>();
    final schedule = controller.selectedSchedule.value;
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Route: ${schedule?.routeFrom} → ${schedule?.routeTo}'),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _contactCtrl,
                decoration: const InputDecoration(labelText: 'Contact'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  await controller.confirmBooking();
                  if (controller.booking.value != null) {
                    Get.toNamed(AppRoutes.paymentMethod);
                  }
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
