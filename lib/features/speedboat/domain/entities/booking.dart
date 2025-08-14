/// Represents a booking made in the system.
class Booking {
  Booking({
    required this.id,
    required this.scheduleId,
    required this.type,
    required this.paxCount,
    required this.amount,
    required this.status,
    this.heldSeatIds,
    required this.createdAt,
  });

  final String id;
  final String scheduleId;
  final BookingType type;
  final int paxCount;
  final int amount;
  final BookingStatus status;
  final List<String>? heldSeatIds;
  final DateTime createdAt;
}

enum BookingType { speedboat, package }

enum BookingStatus { initiated, awaitingPayment, paid, expired, cancelled }
