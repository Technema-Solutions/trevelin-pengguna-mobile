import 'package:get/get.dart';

import '../../domain/entities/payment_intent.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/entities/payment_status.dart';
import '../../domain/repositories/payment_repo.dart';
import '../../../../core/utils/idempotency.dart';
import '../../../speedboat/presentation/controllers/speedboat_controller.dart';
import '../../data/repositories/payment_repo_impl.dart';

class PaymentController extends GetxController {
  PaymentController(this.repo);

  final PaymentRepository repo;

  Rx<PaymentMethod?> selected = Rx<PaymentMethod?>(null);
  Rx<PaymentIntent?> intent = Rx<PaymentIntent?>(null);
  Rx<PaymentStatus> status = PaymentStatus.pending.obs;

  Future<void> chooseMethod(PaymentMethod m) async {
    selected.value = m;
  }

  Future<void> createAndStart({
    required String bookingId,
    required int amount,
  }) async {
    final method = selected.value!;
    final idk = createIdempotencyKey(bookingId, amount, method);
    final res = await repo.createIntent(
      bookingId: bookingId,
      amount: amount,
      method: method,
      idempotencyKey: idk,
    );
    if (res.isSuccess) {
      final ok = res.data!;
      intent.value = ok;
      status.value = ok.status;
      Future.delayed(const Duration(seconds: 2), () async {
        await (repo as PaymentRepositoryImpl)
            .gateway
            .simulateProviderSetPaid(ok.id);
      });
    } else {
      Get.snackbar('Payment', 'Failed: ${res.error}');
    }
  }

  Future<void> pollUntilDone() async {
    final id = intent.value!.id;
    final s = await repo.pollStatus(
        paymentId: id, totalTimeout: const Duration(seconds: 30));
    if (s.isSuccess) {
      status.value = s.data!;
      if (status.value == PaymentStatus.paid) {
        final sb = Get.find<SpeedboatController>();
        final intentVal = intent.value!;
        final confirm = await (repo as PaymentRepositoryImpl)
            .bookingRepo
            .confirmBooking(intentVal.bookingId);
        if (confirm.isSuccess) {
          sb.booking.value = confirm.data;
        }
      }
    } else {
      Get.snackbar('Payment', 'Poll error: ${s.error}');
    }
  }
}
