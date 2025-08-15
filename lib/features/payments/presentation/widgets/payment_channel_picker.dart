import 'package:flutter/material.dart';

import '../../domain/entities/payment_method.dart';

class PaymentChannelPicker extends StatelessWidget {
  const PaymentChannelPicker({super.key, required this.onSelected});

  final ValueChanged<PaymentMethod> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Virtual Account'),
          onTap: () => onSelected(
            const PaymentMethod(channel: PaymentChannel.va, bankCode: 'BCA'),
          ),
        ),
        ListTile(
          title: const Text('E-Wallet'),
          onTap: () => onSelected(
            const PaymentMethod(channel: PaymentChannel.ewallet, ewalletType: 'OVO'),
          ),
        ),
        ListTile(
          title: const Text('QRIS'),
          onTap: () => onSelected(
            const PaymentMethod(channel: PaymentChannel.qris),
          ),
        ),
        ListTile(
          title: const Text('Card'),
          onTap: () => onSelected(
            const PaymentMethod(channel: PaymentChannel.card),
          ),
        ),
      ],
    );
  }
}
