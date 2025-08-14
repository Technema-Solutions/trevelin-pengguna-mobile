import 'package:flutter/material.dart';
import '../../domain/entities/review.dart';

/// Displays a list of reviews for a package.
class ReviewList extends StatelessWidget {
  const ReviewList({super.key, required this.reviews});

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Center(child: Text('No reviews'));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final r = reviews[index];
        return ListTile(
          title: Text(r.userName),
          subtitle: Text(r.comment),
          trailing: Text(r.rating.toString()),
        );
      },
    );
  }
}
