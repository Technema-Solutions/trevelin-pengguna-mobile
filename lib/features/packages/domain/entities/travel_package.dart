import 'itinerary_day.dart';
import 'review.dart';

/// Represents a travel package offering.
class TravelPackage {
  TravelPackage({
    required this.id,
    required this.title,
    required this.location,
    required this.gallery,
    required this.pricePerPax,
    required this.overview,
    required this.latitude,
    required this.longitude,
    required this.minPax,
    required this.maxPax,
    required this.type,
    required this.itinerary,
    required this.reviews,
  });

  final String id;
  final String title;
  final String location;
  final List<String> gallery;
  final int pricePerPax;
  final String overview;
  final double latitude;
  final double longitude;
  final int minPax;
  final int maxPax;
  final PackageType type;
  final List<ItineraryDay> itinerary;
  final List<Review> reviews;
}

enum PackageType { open, private }
