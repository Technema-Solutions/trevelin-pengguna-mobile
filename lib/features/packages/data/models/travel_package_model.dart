import '../../domain/entities/travel_package.dart';
import '../../domain/entities/itinerary_day.dart';
import '../../domain/entities/review.dart';
import 'itinerary_day_model.dart';
import 'review_model.dart';

/// DTO for [TravelPackage].
class TravelPackageModel {
  TravelPackageModel({
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
  final List<ItineraryDayModel> itinerary;
  final List<ReviewModel> reviews;

  factory TravelPackageModel.fromJson(Map<String, dynamic> json) {
    return TravelPackageModel(
      id: json['id'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      gallery: (json['gallery'] as List<dynamic>).cast<String>(),
      pricePerPax: json['pricePerPax'] as int,
      overview: json['overview'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      minPax: json['minPax'] as int,
      maxPax: json['maxPax'] as int,
      type: PackageType.values.firstWhere((e) => e.name == json['type']),
      itinerary: (json['itinerary'] as List<dynamic>)
          .map((e) => ItineraryDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  TravelPackage toEntity() => TravelPackage(
        id: id,
        title: title,
        location: location,
        gallery: gallery,
        pricePerPax: pricePerPax,
        overview: overview,
        latitude: latitude,
        longitude: longitude,
        minPax: minPax,
        maxPax: maxPax,
        type: type,
        itinerary: itinerary.map((e) => e.toEntity()).toList(),
        reviews: reviews.map((e) => e.toEntity()).toList(),
      );
}
