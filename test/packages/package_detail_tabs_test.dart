import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:trevelin_mobile_app/features/packages/presentation/pages/package_detail_page.dart';
import 'package:trevelin_mobile_app/features/packages/presentation/controllers/package_detail_controller.dart';
import 'package:trevelin_mobile_app/features/packages/data/repositories/package_repo_impl.dart';
import 'package:trevelin_mobile_app/features/packages/data/datasources/package_remote_mock.dart';

void main() {
  testWidgets('tabs switch content', (tester) async {
    Get.put(PackageDetailController(repo: PackageRepoImpl(PackageRemoteMock())));
    await tester.pumpWidget(GetMaterialApp(home: const PackageDetailPage()));
    await tester.pumpAndSettle();

    expect(find.text('Overview'), findsOneWidget);

    await tester.tap(find.text('Itinerary'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Day'), findsWidgets);

    await tester.tap(find.text('Location'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Location:'), findsOneWidget);

    await tester.tap(find.text('Reviews'));
    await tester.pumpAndSettle();
    expect(find.text('Tripnya mantap!'), findsOneWidget);
  });
}
