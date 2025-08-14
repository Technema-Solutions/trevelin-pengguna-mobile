import 'package:flutter_test/flutter_test.dart';
import 'package:trevelin_mobile_app/features/speedboat/data/datasources/speedboat_remote_mock.dart';
import 'package:trevelin_mobile_app/features/speedboat/data/repositories/speedboat_repo_impl.dart';
import 'package:trevelin_mobile_app/features/speedboat/domain/entities/booking.dart';

void main() {
  test('booking flow confirm sets status to paid', () async {
    final repo = SpeedboatRepoImpl(SpeedboatRemoteMock());
    final create = await repo.createBooking(
      scheduleId: 'sch-001',
      seatIds: ['s1'],
      paxCount: 1,
    );
    expect(create.isSuccess, isTrue);
    expect(create.data!.status, BookingStatus.awaitingPayment);

    final confirm = await repo.confirmBooking(create.data!.id);
    expect(confirm.isSuccess, isTrue);
    expect(confirm.data!.status, BookingStatus.paid);
  });
}
