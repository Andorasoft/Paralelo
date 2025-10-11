/// Represents a registered user in the application.
///
/// This class models the `app_user` entity from the database,
/// storing personal details, contact information, and university affiliation.
class AppUser {
  /// Unique identifier of the user (primary key).
  final String id;

  /// Date and time when the account was created.
  final DateTime createdAt;

  /// User’s given name.
  final String firstName;

  /// User’s family name.
  final String lastName;

  /// User’s email address, used for authentication and notifications.
  final String email;

  /// Optional profile picture URL. Can be `null`.
  final String? pictureUrl;

  /// Identifier of the university associated with the user.
  final int? universityId;

  /// Optional device token for push notifications.
  final String? deviceToken;

  /// Creates an immutable [AppUser] instance.
  ///
  /// All fields are required except [pictureUrl].
  const AppUser({
    required this.id,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.pictureUrl,
    this.universityId,
    this.deviceToken,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      pictureUrl: map['picture_url'],
      universityId: map['university_id'],
      deviceToken: map['device_token'],
    );
  }
}
