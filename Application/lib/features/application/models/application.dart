/// Represents an `application` entity from the database.
///
/// Stores versioning and maintenance configuration for the mobile app.
class Application {
  /// Unique identifier of the application record.
  final String id;

  /// Timestamp when the record was last updated.
  final DateTime updatedAt;

  /// Platform name (e.g., "ANDROID", "IOS").
  final String platform;

  /// Minimum supported version of the app.
  final String minVersion;

  /// Latest available version of the app.
  final String latestVersion;

  /// Whether the update must be forced for users.
  final bool forceUpdate;

  /// Whether the application is under maintenance.
  final bool maintenanceMode;

  /// Optional message shown during maintenance mode.
  final String? maintenanceMessage;

  const Application({
    required this.id,
    required this.updatedAt,
    required this.platform,
    required this.minVersion,
    required this.latestVersion,
    required this.forceUpdate,
    required this.maintenanceMode,
    this.maintenanceMessage,
  });

  /// Builds an [Application] object from a database map.
  factory Application.fromMap(Map<String, dynamic> map) => Application(
    id: map['id'],
    updatedAt: DateTime.parse(map['updated_at']),
    platform: map['platform'],
    minVersion: map['min_version'],
    latestVersion: map['latest_version'],
    forceUpdate: map['force_update'],
    maintenanceMode: map['maintenance_mode'],
    maintenanceMessage: map['maintenance_message'],
  );
}
