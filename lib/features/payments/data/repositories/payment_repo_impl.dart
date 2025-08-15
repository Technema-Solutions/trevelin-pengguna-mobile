import '../../../../core/utils/idempotency.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/payment_intent.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/entities/payment_status.dart';
import '../../domain/repositories/payment_repo.dart';
import '../../domain/services/payment_gateway.dart';
import '../../../speedboat/domain/repositories/speedboat_repo.dart';
import '../../../../data/storage/local_store.dart';

/// Implementation of [PaymentRepository] wrapping a [PaymentGateway].
class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl({
    required this.gateway,
    required this.store,
    required this.bookingRepo,
  });

  final PaymentGateway gateway;
  final LocalStore store;
  final SpeedboatRepo bookingRepo;

  @override
  Future<Result<PaymentIntent>> createIntent({
    required String bookingId,
    required int amount,
    required PaymentMethod method,
    String? idempotencyKey,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final key = idempotencyKey ??
          createIdempotencyKey(bookingId, amount, method);
      final intent = await gateway.createIntent(
        bookingId: bookingId,
        amount: amount,
        method: method,
        idempotencyKey: key,
        metadata: metadata,
      );
      return Result.success(intent);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<PaymentIntent>> getIntent(String paymentId) async {
    try {
      final intent = await gateway.getIntent(paymentId);
      return Result.success(intent);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<PaymentStatus>> pollStatus({
    required String paymentId,
    Duration totalTimeout = const Duration(minutes: 2),
  }) async {
    final end = DateTime.now().add(totalTimeout);
    var delay = const Duration(seconds: 1);
    while (DateTime.now().isBefore(end)) {
      try {
        final intent = await gateway.getIntent(paymentId);
        final status = intent.status;
        if (status == PaymentStatus.paid ||
            status == PaymentStatus.failed ||
            status == PaymentStatus.cancelled ||
            status == PaymentStatus.expired) {
          if (status == PaymentStatus.paid) {
            await bookingRepo.confirmBooking(intent.bookingId);
            await store.write('lastPaymentId', paymentId);
          }
          return Result.success(status);
        }
      } catch (e) {
        return Result.failure(e);
      }
      await Future.delayed(delay);
      delay *= 2;
    }
    return Result.failure('timeout');
  }

  @override
  Future<Result<void>> handleWebhook(Map<String, dynamic> payload) async {
    try {
      final data = payload['data'] as Map<String, dynamic>;
      final paymentId = data['paymentId'] as String;
      final key = 'webhook:$paymentId:done';
      if (store.read<bool>(key) == true) {
        return Result.success(null);
      }
      final status = data['status'] as String?;
      if (status == 'paid') {
        final intent = await gateway.getIntent(paymentId);
        await bookingRepo.confirmBooking(intent.bookingId);
        await store.write('lastPaymentId', paymentId);
      }
      await store.write(key, true);
      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
