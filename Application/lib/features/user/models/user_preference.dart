/// Represents a `user_preference` entity from the database.
///
/// Stores user settings such as language, theme, and notifications.
class UserPreference {
  /// Unique identifier of the preference record.
  final int id;

  /// Timestamp when the record was last updated.
  final DateTime updatedAt;

  /// Preferred language (e.g., "en", "es").
  final String language;

  /// Whether dark mode is enabled.
  final bool darkMode;

  /// Whether notifications are enabled.
  final bool notificationsEnabled;

  /// UUID of the related user.
  final String userId;

  const UserPreference({
    required this.id,
    required this.updatedAt,
    required this.language,
    required this.darkMode,
    required this.notificationsEnabled,
    required this.userId,
  });

  /// Builds a [UserPreference] object from a database map.
  factory UserPreference.fromMap(Map<String, dynamic> map) {
    return UserPreference(
      id: map['id'],
      updatedAt: DateTime.parse(map['updated_at']),
      language: map['language'],
      darkMode: map['dark_mode'],
      notificationsEnabled: map['notifications_enabled'],
      userId: map['user_id'],
    );
  }
}
