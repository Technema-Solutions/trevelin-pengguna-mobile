import '../../domain/entities/schedule.dart';
import '../../domain/entities/seat.dart';

/// Data transfer object for [Schedule].
class ScheduleModel {
  ScheduleModel({
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
  final List<SeatModel>? seatMap;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'] as String,
      routeFrom: json['routeFrom'] as String,
      routeTo: json['routeTo'] as String,
      departAt: DateTime.parse(json['departAt'] as String),
      arriveAt: DateTime.parse(json['arriveAt'] as String),
      serviceType: SpeedboatServiceType.values
          .firstWhere((e) => e.name == json['serviceType']),
      capacity: json['capacity'] as int,
      status: ScheduleStatus.values
          .firstWhere((e) => e.name == json['status']),
      pricePerSeat: json['pricePerSeat'] as int?,
      charterPrice: json['charterPrice'] as int?,
      seatMap: (json['seatMap'] as List<dynamic>?)
          ?.map((e) => SeatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Schedule toEntity() => Schedule(
        id: id,
        routeFrom: routeFrom,
        routeTo: routeTo,
        departAt: departAt,
        arriveAt: arriveAt,
        serviceType: serviceType,
        capacity: capacity,
        status: status,
        pricePerSeat: pricePerSeat,
        charterPrice: charterPrice,
        seatMap: seatMap?.map((e) => e.toEntity()).toList(),
      );
}

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
