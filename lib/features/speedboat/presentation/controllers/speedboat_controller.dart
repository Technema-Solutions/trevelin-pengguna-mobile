import 'package:get/get.dart';

import '../../domain/entities/booking.dart';
import '../../domain/entities/schedule.dart';
import '../../domain/entities/seat.dart';
import '../../domain/repositories/speedboat_repo.dart';

/// Controller for speedboat related UI flow.
class SpeedboatController extends GetxController {
  SpeedboatController({required this.repo});

  final SpeedboatRepo repo;

  final schedules = <Schedule>[].obs;
  final selectedSchedule = Rxn<Schedule>();
  final seatMap = <Seat>[].obs;
  final selectedSeatIds = <String>[].obs;
  final booking = Rxn<Booking>();

  int get totalPrice =>
      (selectedSchedule.value?.pricePerSeat ?? 0) * selectedSeatIds.length;

  Future<void> loadSchedules() async {
    final res = await repo.getSchedules();
    if (res.isSuccess) {
      schedules.assignAll(res.data!);
    }
  }

  Future<void> loadSeatMap(String scheduleId) async {
    final res = await repo.getSeatMap(scheduleId);
    if (res.isSuccess) {
      seatMap.assignAll(res.data!);
    }
  }

  void toggleSeat(String id) {
    final seat = seatMap.firstWhereOrNull((e) => e.id == id);
    if (seat == null || seat.status == SeatStatus.sold) return;
    if (selectedSeatIds.contains(id)) {
      selectedSeatIds.remove(id);
    } else {
      selectedSeatIds.add(id);
    }
  }

  Future<void> confirmBooking() async {
    final schedule = selectedSchedule.value;
    if (schedule == null) return;
    final createRes = await repo.createBooking(
      scheduleId: schedule.id,
      seatIds: selectedSeatIds.toList(),
      paxCount: selectedSeatIds.length,
    );
    if (!createRes.isSuccess) return;
    final confirmRes = await repo.confirmBooking(createRes.data!.id);
    if (confirmRes.isSuccess) {
      booking.value = confirmRes.data;
    }
  }
}
