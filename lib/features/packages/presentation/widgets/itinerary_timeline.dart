import 'package:flutter/material.dart';
import '../../domain/entities/itinerary_day.dart';

/// Displays itinerary items in a simple column.
class ItineraryTimeline extends StatelessWidget {
  const ItineraryTimeline({super.key, required this.days});

  final List<ItineraryDay> days;

  @override
  Widget build(BuildContext context) {
    if (days.isEmpty) {
      return const Center(child: Text('No itinerary'));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final d = days[index];
        return ListTile(
          title: Text('Day ${d.day}: ${d.title}'),
          subtitle: Text(d.activities.join(', ')),
        );
      },
    );
  }
}
