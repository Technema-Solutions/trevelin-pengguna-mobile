import 'payment_method.dart';
import 'payment_status.dart';

class PaymentIntent {
  final String id;                 // payment_id from provider
  final String bookingId;
  final int amount;
  final PaymentMethod method;
  final PaymentStatus status;
  final String? redirectUrl;       // ewallet/card
  final String? vaNumber;          // VA
  final String? qrisPayload;       // QR string to render
  final DateTime createdAt;
  final DateTime expiresAt;
  const PaymentIntent({
    required this.id,
    required this.bookingId,
    required this.amount,
    required this.method,
    required this.status,
    this.redirectUrl,
    this.vaNumber,
    this.qrisPayload,
    required this.createdAt,
    required this.expiresAt,
  });
}
