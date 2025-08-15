import '../entities/payment_intent.dart';
import '../entities/payment_method.dart';

abstract class PaymentGateway {
  Future<PaymentIntent> createIntent({
    required String bookingId,
    required int amount,
    required PaymentMethod method,
    required String idempotencyKey,
    Map<String, dynamic>? metadata,
  });

  Future<PaymentIntent> getIntent(String paymentId);

  /// Simulates provider-side async update; real impl will be triggered via webhook.
  Future<void> simulateProviderSetPaid(String paymentId); // mock only
}
