/// Represents a speedboat schedule.
class Schedule {
  Schedule({
    required this.id,
    required this.routeFrom,
    required this.routeTo,
    required this.departAt,
    required this.arriveAt,
    required this.serviceType,
    required this.capacity,
    required this.status,
    this.pricePerSeat,
    this.charterPrice,
    this.seatMap,
  });

  final String id;
  final String routeFrom;
  final String routeTo;
  final DateTime departAt;
  final DateTime arriveAt;
  final SpeedboatServiceType serviceType;
  final int capacity;
  final ScheduleStatus status;
  final int? pricePerSeat;
  final int? charterPrice;
  final List<Seat>? seatMap;
}

enum SpeedboatServiceType { regular, charter }

enum ScheduleStatus { published, soldOut, cancelled }
