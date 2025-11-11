/// Represents a `user_rating` entity from the database.
///
/// Stores feedback and numeric scores between users.
class UserRating {
  /// Unique identifier of the rating record.
  final String id;

  /// Timestamp when the rating was created.
  final DateTime createdAt;

  /// Numeric score given by the rater.
  final num score;

  /// Optional comment.
  final String? comment;

  /// UUID of the rater.
  final String raterId;

  /// UUID of the rated user.
  final String ratedId;

  /// Related project ID.
  final String projectId;

  const UserRating({
    required this.id,
    required this.createdAt,
    required this.score,
    this.comment,
    required this.raterId,
    required this.ratedId,
    required this.projectId,
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
