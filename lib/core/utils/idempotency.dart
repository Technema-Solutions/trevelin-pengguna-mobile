import 'dart:convert';
import 'package:crypto/crypto.dart';

import '../../features/payments/domain/entities/payment_method.dart';

/// Creates a deterministic idempotency key based on booking and method info.
String createIdempotencyKey(
  String bookingId,
  int amount,
  PaymentMethod method,
) {
  final bucket = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 60000; // minute bucket
  final raw =
      '$bookingId|$amount|${method.channel.name}|${method.bankCode ?? ''}|${method.ewalletType ?? ''}|$bucket';
  return sha1.convert(utf8.encode(raw)).toString();
}
