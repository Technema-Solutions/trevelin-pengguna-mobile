import '../entities/booking.dart';
import '../entities/schedule.dart';
import '../entities/seat.dart';
import '../../../../core/utils/result.dart';

/// Repository for speedboat operations.
abstract class SpeedboatRepo {
  Future<Result<List<Schedule>>> getSchedules();
  Future<Result<Schedule>> getSchedule(String id);
  Future<Result<List<Seat>>> getSeatMap(String scheduleId);
  Future<Result<Booking>> createBooking({
    required String scheduleId,
    List<String>? seatIds,
    required int paxCount,
  });
  Future<Result<Booking>> confirmBooking(String bookingId);
}
