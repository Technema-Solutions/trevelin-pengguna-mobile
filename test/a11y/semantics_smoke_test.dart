import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:trevelin_mobile_app/features/speedboat/data/datasources/speedboat_remote_mock.dart';
import 'package:trevelin_mobile_app/features/speedboat/data/repositories/speedboat_repo_impl.dart';
import 'package:trevelin_mobile_app/features/speedboat/presentation/controllers/speedboat_controller.dart';
import 'package:trevelin_mobile_app/features/speedboat/presentation/pages/seat_map_page.dart';

void main() {
  testWidgets('seat has semantics label', (tester) async {
    final repo = SpeedboatRepoImpl(SpeedboatRemoteMock());
    final controller = SpeedboatController(repo: repo);
    Get.put(controller);
    controller.loadSeatMap('sch-001');
    await tester.pumpWidget(const GetMaterialApp(home: SeatMapPage()));
    await tester.pumpAndSettle();
    final node = tester.getSemantics(find.text('s1'));
    expect(node.label, 'Seat s1');
  });
}
