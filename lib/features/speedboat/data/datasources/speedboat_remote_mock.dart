import 'dart:math';

import '../models/booking_model.dart';
import '../models/schedule_model.dart';
import '../models/seat_model.dart';
import '../../domain/entities/seat.dart';

/// Mock remote data source for speedboat operations.
class SpeedboatRemoteMock {
  final _rng = Random(1);
  final Map<String, BookingModel> _bookings = {};

  List<Map<String, dynamic>> get _scheduleJson => [
        {
          'id': 'sch-001',
          'routeFrom': 'TARAKAN',
          'routeTo': 'TANJUNG SELOR',
          'departAt': '2025-09-01T08:00:00Z',
          'arriveAt': '2025-09-01T09:15:00Z',
          'serviceType': 'regular',
          'capacity': 32,
          'status': 'published',
          'pricePerSeat': 85000,
        },
        {
          'id': 'sch-002',
          'routeFrom': 'TARAKAN',
          'routeTo': 'DERAWAN',
          'departAt': '2025-09-01T10:00:00Z',
          'arriveAt': '2025-09-01T11:45:00Z',
          'serviceType': 'charter',
          'capacity': 10,
          'status': 'published',
          'charterPrice': 1200000,
        },
      ];

  Future<List<ScheduleModel>> getSchedules() async {
    return _scheduleJson.map(ScheduleModel.fromJson).toList();
  }

  Future<ScheduleModel> getSchedule(String id) async {
    final json = _scheduleJson.firstWhere((e) => e['id'] == id);
    return ScheduleModel.fromJson(json);
  }

  Future<List<SeatModel>> getSeatMap(String scheduleId) async {
    // generate 4x8 grid
    final List<SeatModel> seats = [];
    for (int i = 0; i < 32; i++) {
      final status = _rng.nextInt(5) == 0 ? 'sold' : 'free';
      seats.add(SeatModel(
        id: 's$i',
        code: 'A${i + 1}',
        status: SeatStatus.values.firstWhere((e) => e.name == status),
      ));
    }
    return seats;
  }

  Future<BookingModel> createBooking(
      {required String scheduleId,
      List<String>? seatIds,
      required int paxCount}) async {
    final id = 'book-${_bookings.length + 1}';
    final amount = 85000 * paxCount;
    final booking = BookingModel(
      id: id,
      scheduleId: scheduleId,
      type: BookingType.speedboat,
      paxCount: paxCount,
      amount: amount,
      status: BookingStatus.awaitingPayment,
      heldSeatIds: seatIds,
      createdAt: DateTime.now(),
    );
    _bookings[id] = booking;
    return booking;
  }

  Future<BookingModel> confirmBooking(String bookingId) async {
    final booking = _bookings[bookingId]!;
    final confirmed = BookingModel(
      id: booking.id,
      scheduleId: booking.scheduleId,
      type: booking.type,
      paxCount: booking.paxCount,
      amount: booking.amount,
      status: BookingStatus.paid,
      heldSeatIds: booking.heldSeatIds,
      createdAt: booking.createdAt,
    );
    _bookings[bookingId] = confirmed;
    return confirmed;
  }
}
