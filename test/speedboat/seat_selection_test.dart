import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:trevelin_mobile_app/features/speedboat/presentation/pages/seat_map_page.dart';
import 'package:trevelin_mobile_app/features/speedboat/presentation/controllers/speedboat_controller.dart';
import 'package:trevelin_mobile_app/features/speedboat/domain/entities/schedule.dart';
import 'package:trevelin_mobile_app/features/speedboat/domain/entities/seat.dart';
import 'package:trevelin_mobile_app/features/speedboat/data/repositories/speedboat_repo_impl.dart';
import 'package:trevelin_mobile_app/features/speedboat/data/datasources/speedboat_remote_mock.dart';

void main() {
  testWidgets('selecting seats updates total price', (tester) async {
    Get.put(SpeedboatController(repo: SpeedboatRepoImpl(SpeedboatRemoteMock())));
    final controller = Get.find<SpeedboatController>();
    controller.selectedSchedule.value = Schedule(
      id: 'sch-test',
      routeFrom: 'A',
      routeTo: 'B',
      departAt: DateTime.now(),
      arriveAt: DateTime.now(),
      serviceType: SpeedboatServiceType.regular,
      capacity: 12,
      status: ScheduleStatus.published,
      pricePerSeat: 85000,
    );
    controller.seatMap.assignAll(List.generate(12, (i) {
      return Seat(
        id: 's$i',
        code: 'A${i + 1}',
        status: i == 2 ? SeatStatus.sold : SeatStatus.free,
      );
    }));

    await tester.pumpWidget(GetMaterialApp(home: const SeatMapPage()));

    await tester.tap(find.text('A1'));
    await tester.tap(find.text('A2'));
    await tester.pump();
    expect(find.text('Total: Rp170.000,00'), findsOneWidget);

    // Try selecting sold seat
    await tester.tap(find.text('A3'));
    await tester.pump();
    expect(controller.selectedSeatIds.length, 2);
  });
}
