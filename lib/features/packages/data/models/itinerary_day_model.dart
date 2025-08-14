import '../../domain/entities/itinerary_day.dart';

/// DTO for [ItineraryDay].
class ItineraryDayModel {
  ItineraryDayModel({
    required this.day,
    required this.title,
    required this.activities,
    required this.meals,
  });

  final int day;
  final String title;
  final List<String> activities;
  final List<String> meals;

  factory ItineraryDayModel.fromJson(Map<String, dynamic> json) =>
      ItineraryDayModel(
        day: json['day'] as int,
        title: json['title'] as String,
        activities: (json['activities'] as List<dynamic>).cast<String>(),
        meals: (json['meals'] as List<dynamic>).cast<String>(),
      );

  ItineraryDay toEntity() => ItineraryDay(
        day: day,
        title: title,
        activities: activities,
        meals: meals,
      );
}
