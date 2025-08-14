/// Review left by a user for a package.
class Review {
  Review({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  final String userName;
  final double rating;
  final String comment;
  final DateTime createdAt;
}
