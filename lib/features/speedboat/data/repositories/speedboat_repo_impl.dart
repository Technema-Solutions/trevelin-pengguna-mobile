import '../../domain/entities/booking.dart';
import '../../domain/entities/schedule.dart';
import '../../domain/entities/seat.dart';
import '../../domain/repositories/speedboat_repo.dart';
import '../../../../core/utils/result.dart';
import '../datasources/speedboat_remote_mock.dart';

/// Implementation of [SpeedboatRepo] using a mock remote data source.
class SpeedboatRepoImpl implements SpeedboatRepo {
  SpeedboatRepoImpl(this.remote);

  final SpeedboatRemoteMock remote;

  @override
  Future<Result<Booking>> confirmBooking(String bookingId) async {
    try {
      final data = await remote.confirmBooking(bookingId);
      return Result.success(data.toEntity());
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<Booking>> createBooking({
    required String scheduleId,
    List<String>? seatIds,
    required int paxCount,
  }) async {
    try {
      final data = await remote.createBooking(
          scheduleId: scheduleId, seatIds: seatIds, paxCount: paxCount);
      return Result.success(data.toEntity());
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<Schedule>> getSchedule(String id) async {
    try {
      final data = await remote.getSchedule(id);
      return Result.success(data.toEntity());
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<Schedule>>> getSchedules() async {
    try {
      final data = await remote.getSchedules();
      return Result.success(data.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<Seat>>> getSeatMap(String scheduleId) async {
    try {
      final data = await remote.getSeatMap(scheduleId);
      return Result.success(data.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.failure(e);
    }
  }
}
