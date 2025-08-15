import '../../../../core/utils/result.dart';
import '../entities/payment_intent.dart';
import '../entities/payment_method.dart';
import '../entities/payment_status.dart';

abstract class PaymentRepository {
  Future<Result<PaymentIntent>> createIntent({
    required String bookingId,
    required int amount,
    required PaymentMethod method,
    String? idempotencyKey, // to avoid dup intents
    Map<String, dynamic>? metadata,
  });

  Future<Result<PaymentIntent>> getIntent(String paymentId);

  /// Poll provider for status updates with exponential backoff.
  Future<Result<PaymentStatus>> pollStatus({
    required String paymentId,
    Duration totalTimeout = const Duration(minutes: 2),
  });

  /// Handle webhook payload (mock for now). Must be idempotent.
  Future<Result<void>> handleWebhook(Map<String, dynamic> payload);
}
