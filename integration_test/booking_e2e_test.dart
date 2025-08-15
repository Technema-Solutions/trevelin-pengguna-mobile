import 'package:flutter_test/flutter_test.dart';
import 'package:trevelin_mobile_app/features/speedboat/data/datasources/speedboat_remote_mock.dart';
import 'package:trevelin_mobile_app/features/speedboat/data/repositories/speedboat_repo_impl.dart';
import 'package:trevelin_mobile_app/features/speedboat/domain/entities/booking.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('booking flow reaches paid status', () async {
    final repo = SpeedboatRepoImpl(SpeedboatRemoteMock());
    final create = await repo.createBooking(
      scheduleId: 'sch-001',
      seatIds: ['s1', 's2'],
      paxCount: 2,
    );
    expect(create.isSuccess, isTrue);
    final confirm = await repo.confirmBooking(create.data!.id);
    expect(confirm.isSuccess, isTrue);
    expect(confirm.data!.status, BookingStatus.paid);
  });
}
