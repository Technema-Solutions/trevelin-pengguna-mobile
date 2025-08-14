import '../../domain/entities/review.dart';

/// DTO for [Review].
class ReviewModel {
  ReviewModel({
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  final String userName;
  final double rating;
  final String comment;
  final DateTime createdAt;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        userName: json['userName'] as String,
        rating: (json['rating'] as num).toDouble(),
        comment: json['comment'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Review toEntity() => Review(
        userName: userName,
        rating: rating,
        comment: comment,
        createdAt: createdAt,
      );
}
