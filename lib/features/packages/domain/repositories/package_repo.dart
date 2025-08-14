import '../../../../core/utils/result.dart';
import '../entities/travel_package.dart';

/// Repository for travel packages.
abstract class PackageRepo {
  Future<Result<TravelPackage>> getPackage(String id);
}
