import 'package:get/get.dart';

import '../../domain/entities/travel_package.dart';
import '../../domain/repositories/package_repo.dart';

/// Controller for package detail page.
class PackageDetailController extends GetxController {
  PackageDetailController({required this.repo});

  final PackageRepo repo;

  final pkg = Rxn<TravelPackage>();
  final activeTabIndex = 0.obs;

  Future<void> loadPackage(String id) async {
    final res = await repo.getPackage(id);
    if (res.isSuccess) {
      pkg.value = res.data;
    }
  }
}
