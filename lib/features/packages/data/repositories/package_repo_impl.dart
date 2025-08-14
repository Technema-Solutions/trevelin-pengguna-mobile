import '../../../../core/utils/result.dart';
import '../../domain/entities/travel_package.dart';
import '../../domain/repositories/package_repo.dart';
import '../datasources/package_remote_mock.dart';

/// Implementation of [PackageRepo] using mock datasource.
class PackageRepoImpl implements PackageRepo {
  PackageRepoImpl(this.remote);

  final PackageRemoteMock remote;

  @override
  Future<Result<TravelPackage>> getPackage(String id) async {
    try {
      final data = await remote.getPackage(id);
      return Result.success(data.toEntity());
    } catch (e) {
      return Result.failure(e);
    }
  }
}
