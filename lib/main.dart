import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'features/speedboat/presentation/controllers/speedboat_controller.dart';
import 'features/packages/presentation/controllers/package_detail_controller.dart';
import 'features/speedboat/data/repositories/speedboat_repo_impl.dart';
import 'features/speedboat/data/datasources/speedboat_remote_mock.dart';
import 'features/packages/data/repositories/package_repo_impl.dart';
import 'features/packages/data/datasources/package_remote_mock.dart';

void main() {
  final speedboatRepo = SpeedboatRepoImpl(SpeedboatRemoteMock());
  final packageRepo = PackageRepoImpl(PackageRemoteMock());
  Get.put(SpeedboatController(repo: speedboatRepo));
  Get.put(PackageDetailController(repo: packageRepo));
  runApp(const TrevelinApp());
}

class TrevelinApp extends StatelessWidget {
  const TrevelinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Trevelin',
      theme: AppTheme.light,
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.speedboat,
    );
  }
}
