import '../../domain/entities/booking.dart';

/// DTO for [Booking].
class BookingModel {
  BookingModel({
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

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'] as String,
        scheduleId: json['scheduleId'] as String,
        type: BookingType.values.firstWhere((e) => e.name == json['type']),
        paxCount: json['paxCount'] as int,
        amount: json['amount'] as int,
        status:
            BookingStatus.values.firstWhere((e) => e.name == json['status']),
        heldSeatIds: (json['heldSeatIds'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Booking toEntity() => Booking(
        id: id,
        scheduleId: scheduleId,
        type: type,
        paxCount: paxCount,
        amount: amount,
        status: status,
        heldSeatIds: heldSeatIds,
        createdAt: createdAt,
      );
}
