enum PackageType { openTrip, privateTrip }

class TravelPackage {
  final String id;
  final String name;
  final String destination;
  final String description;
  final PackageType packageType;
  final double price;
  final String duration;
  final int minParticipants;
  final int maxParticipants;
  final int currentParticipants;
  final List<String> highlights;
  final List<String> includes;
  final List<String> excludes;
  final List<String> facilities;
  final List<String> requirements;
  final String meetingPoint;
  final String departurePoint;
  final DateTime departureDate;
  final DateTime returnDate;
  final String organizer;
  final String organizerLogo;
  final bool isVerified;
  final double rating;
  final int totalReviews;
  final List<String> images;

  const TravelPackage({
    required this.id,
    required this.name,
    required this.destination,
    required this.description,
    required this.packageType,
    required this.price,
    required this.duration,
    required this.minParticipants,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.highlights,
    required this.includes,
    required this.excludes,
    required this.facilities,
    required this.requirements,
    required this.meetingPoint,
    required this.departurePoint,
    required this.departureDate,
    required this.returnDate,
    required this.organizer,
    required this.organizerLogo,
    required this.isVerified,
    required this.rating,
    required this.totalReviews,
    required this.images,
  });

  String get statusText {
    final remaining = maxParticipants - currentParticipants;
    if (remaining <= 0) return 'Penuh';
    if (remaining <= 3) return 'Tersisa $remaining slot';
    return '$remaining slot tersedia';
  }

  String get availabilityStatus {
    final remaining = maxParticipants - currentParticipants;
    if (remaining <= 0) return 'full';
    if (remaining <= 3) return 'limited';
    return 'available';
  }
}
