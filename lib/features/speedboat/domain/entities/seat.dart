/// Represents a seat in a speedboat.
class Seat {
  Seat({required this.id, required this.code, required this.status});

  final String id;
  final String code;
  final SeatStatus status;
}

enum SeatStatus { free, held, sold }
