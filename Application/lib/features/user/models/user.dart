/// Represents a `user` entity from the database.
///
/// Stores general profile and authentication data of each user.
class User {
  /// Unique identifier of the user (UUID).
  final String id;

  /// Timestamp when the user account was created.
  final DateTime createdAt;

  /// Display name chosen by the user.
  final String displayName;

  /// User’s email address.
  final String email;

  /// Whether the user's email has been verified.
  final bool verified;

  /// Optional URL to the user's profile picture.
  final String? pictureUrl;

  /// Optional push notification token (Firebase Cloud Messaging).
  final String? deviceToken;

  /// Identifier of the university associated with the user.
  final int? universityId;

  const User({
    required this.id,
    required this.createdAt,
    required this.displayName,
    required this.email,
    required this.verified,
    this.pictureUrl,
    this.deviceToken,
    this.universityId,
  });

  /// Builds an [User] object from a database map.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      displayName: map['display_name'],
      email: map['email'],
      verified: map['verified'],
      pictureUrl: map['picture_url'],
      deviceToken: map['device_token'],
      universityId: map['university_id'],
    );
  }
}
