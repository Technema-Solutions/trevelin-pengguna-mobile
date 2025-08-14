/// Represents itinerary for a single day within a travel package.
class ItineraryDay {
  ItineraryDay({
    required this.day,
    required this.title,
    required this.activities,
    required this.meals,
  });

  final int day;
  final String title;
  final List<String> activities;
  final List<String> meals;
}
