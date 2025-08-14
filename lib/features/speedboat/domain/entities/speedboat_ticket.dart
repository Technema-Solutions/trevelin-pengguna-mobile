enum ServiceType { reguler, nonReguler }

class SpeedboatTicket {
  final String id;
  final String from;
  final String to;
  final DateTime departureDate;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final double price;
  final int availability;
  final String status; // "available", "limited", "full"
  final String boatName;
  final String boatLogo;
  final ServiceType serviceType;
  final List<String>? availableSeats; // Only for reguler

  const SpeedboatTicket({
    required this.id,
    required this.from,
    required this.to,
    required this.departureDate,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.availability,
    required this.status,
    required this.boatName,
    required this.boatLogo,
    required this.serviceType,
    this.availableSeats,
  });

  factory SpeedboatTicket.fromJson(Map<String, dynamic> json) {
    return SpeedboatTicket(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      departureDate: DateTime.parse(json['departure_date']),
      departureTime: json['departure_time'],
      arrivalTime: json['arrival_time'],
      duration: json['duration'],
      price: json['price'].toDouble(),
      availability: json['availability'],
      status: json['status'],
      boatName: json['boat_name'],
      boatLogo: json['boat_logo'],
      serviceType: json['service_type'] == 'reguler'
          ? ServiceType.reguler
          : ServiceType.nonReguler,
      availableSeats: json['available_seats']?.cast<String>(),
    );
  }
}
