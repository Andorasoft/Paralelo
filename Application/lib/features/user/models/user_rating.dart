/// Represents a `user_rating` entity from the database.
///
/// Stores ratings and comments that users give to each other
/// after completing a project or service.
class UserRating {
  /// Unique identifier of the rating record.
  final int id;

  /// Timestamp when the rating was created.
  final DateTime createdAt;

  /// Numeric score given by the rater (e.g., 1–5).
  final num score;

  /// Optional comment or feedback provided with the rating.
  final String? comment;

  /// UUID of the user who gave the rating.
  final String raterId;

  /// UUID of the user who received the rating.
  final String ratedId;

  /// Identifier of the related project (if applicable).
  final int? projectId;

  /// Creates an immutable [UserRating] instance.
  const UserRating({
    required this.id,
    required this.createdAt,
    required this.score,
    this.comment,
    required this.raterId,
    required this.ratedId,
    this.projectId,
  });

  /// Builds a [UserRating] object from a database map.
  factory UserRating.fromMap(Map<String, dynamic> map) {
    return UserRating(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      score: map['score'],
      comment: map['comment'],
      raterId: map['rater_id'],
      ratedId: map['rated_id'],
      projectId: map['project_id'],
    );
  }
}
