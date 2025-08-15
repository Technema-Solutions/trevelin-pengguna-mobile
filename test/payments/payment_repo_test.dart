import 'package:flutter_test/flutter_test.dart';
import 'package:trevelin_mobile_app/data/storage/local_store.dart';
import 'package:trevelin_mobile_app/features/payments/data/datasources/payment_gateway_mock.dart';
import 'package:trevelin_mobile_app/features/payments/data/repositories/payment_repo_impl.dart';
import 'package:trevelin_mobile_app/features/payments/domain/entities/payment_method.dart';
import 'package:trevelin_mobile_app/features/payments/domain/entities/payment_status.dart';
import 'package:trevelin_mobile_app/features/speedboat/data/datasources/speedboat_remote_mock.dart';
import 'package:trevelin_mobile_app/features/speedboat/data/repositories/speedboat_repo_impl.dart';

void main() {
  late PaymentRepositoryImpl repo;

  setUp(() async {
    final store = await LocalStore.init();
    final bookingRepo = SpeedboatRepoImpl(SpeedboatRemoteMock());
    late PaymentRepositoryImpl tmp;
    final gateway = PaymentGatewayMock(onWebhook: (p) => tmp.handleWebhook(p));
    tmp = PaymentRepositoryImpl(gateway: gateway, store: store, bookingRepo: bookingRepo);
    repo = tmp;
  });

  test('create intent returns channel specific fields', () async {
    final vaMethod = const PaymentMethod(channel: PaymentChannel.va, bankCode: 'BCA');
    final res = await repo.createIntent(
        bookingId: 'b1', amount: 1000, method: vaMethod, idempotencyKey: 'idem1');
    expect(res.isSuccess, isTrue);
    expect(res.data!.vaNumber, isNotNull);

    final qrisMethod = const PaymentMethod(channel: PaymentChannel.qris);
    final res2 = await repo.createIntent(
        bookingId: 'b2', amount: 1000, method: qrisMethod, idempotencyKey: 'idem2');
    expect(res2.isSuccess, isTrue);
    expect(res2.data!.qrisPayload, isNotNull);
  });

  test('poll status becomes paid after simulation', () async {
    final method = const PaymentMethod(channel: PaymentChannel.va, bankCode: 'BCA');
    final create = await repo.createIntent(
        bookingId: 'b3', amount: 1000, method: method, idempotencyKey: 'idem3');
    final id = create.data!.id;
    await repo.gateway.simulateProviderSetPaid(id);
    final status = await repo.pollStatus(paymentId: id, totalTimeout: const Duration(seconds: 5));
    expect(status.isSuccess, isTrue);
    expect(status.data, PaymentStatus.paid);
  });
}
