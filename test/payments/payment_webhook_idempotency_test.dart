import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trevelin_mobile_app/data/storage/local_store.dart';
import 'package:trevelin_mobile_app/features/payments/data/datasources/payment_gateway_mock.dart';
import 'package:trevelin_mobile_app/features/payments/data/repositories/payment_repo_impl.dart';
import 'package:trevelin_mobile_app/features/payments/domain/entities/payment_method.dart';
import 'package:trevelin_mobile_app/features/speedboat/domain/entities/booking.dart';
import 'package:trevelin_mobile_app/features/speedboat/domain/repositories/speedboat_repo.dart';
import 'package:trevelin_mobile_app/core/utils/result.dart';

class MockBookingRepo extends Mock implements SpeedboatRepo {}

void main() {
  late PaymentRepositoryImpl repo;
  late MockBookingRepo bookingRepo;

  setUp(() async {
    bookingRepo = MockBookingRepo();
    when(() => bookingRepo.confirmBooking(any())).thenAnswer((invocation) async {
      return Result.success(Booking(
        id: invocation.positionalArguments.first as String,
        scheduleId: 's',
        type: BookingType.speedboat,
        paxCount: 1,
        amount: 1000,
        status: BookingStatus.paid,
        createdAt: DateTime.now(),
      ));
    });
    final store = await LocalStore.init();
    late PaymentRepositoryImpl tmp;
    final gateway = PaymentGatewayMock(onWebhook: (p) => tmp.handleWebhook(p));
    tmp = PaymentRepositoryImpl(gateway: gateway, store: store, bookingRepo: bookingRepo);
    repo = tmp;
  });

  test('handleWebhook processes once', () async {
    final method = const PaymentMethod(channel: PaymentChannel.va, bankCode: 'BCA');
    final create = await repo.createIntent(
        bookingId: 'b1', amount: 1000, method: method, idempotencyKey: 'k1');
    final id = create.data!.id;
    final payload = {
      'type': 'payment.paid',
      'data': {'paymentId': id, 'status': 'paid'},
      'signature': 'mock'
    };
    await repo.handleWebhook(payload);
    await repo.handleWebhook(payload);
    verify(() => bookingRepo.confirmBooking('b1')).called(1);
  });

  test('idempotent createIntent', () async {
    final method = const PaymentMethod(channel: PaymentChannel.va, bankCode: 'BCA');
    final first = await repo.createIntent(
        bookingId: 'b2', amount: 1000, method: method, idempotencyKey: 'same');
    final second = await repo.createIntent(
        bookingId: 'b2', amount: 1000, method: method, idempotencyKey: 'same');
    expect(first.data!.id, second.data!.id);
  });
}
