import '../../domain/entities/seat.dart';

/// DTO for [Seat].
class SeatModel {
  SeatModel({required this.id, required this.code, required this.status});

  final String id;
  final String code;
  final SeatStatus status;

  factory SeatModel.fromJson(Map<String, dynamic> json) => SeatModel(
        id: json['id'] as String,
        code: json['code'] as String,
        status: SeatStatus.values.firstWhere((e) => e.name == json['status']),
      );

  Seat toEntity() => Seat(id: id, code: code, status: status);
}
