/// Represents a `project_payment` entity from the database.
///
/// Stores payment details for a project, including min/max range,
/// currency, type, and relation to a specific project.
class ProjectPayment {
  /// Unique identifier of the payment record.
  final int id;

  /// Timestamp when the payment record was created.
  final DateTime createdAt;

  /// Minimum amount agreed for the project.
  final double min;

  /// Maximum amount agreed for the project.
  final double max;

  /// Currency code (e.g., "USD").
  final String currency;

  /// Payment type (e.g., "fixed", "hourly").
  final String type;

  /// Identifier of the related project.
  final int projectId;

  /// Creates an immutable [ProjectPayment] instance.
  const ProjectPayment({
    required this.id,
    required this.createdAt,
    required this.min,
    required this.max,
    required this.currency,
    required this.type,
    required this.projectId,
  });

  /// Converts the [ProjectPayment] object into a map
  /// suitable for database storage or JSON encoding.
  Map<String, dynamic> toMap() => {
    'id': id,
    'created_at': createdAt.toIso8601String(),
    'min': min,
    'max': max,
    'currency': currency,
    'type': type,
    'project_id': projectId,
  };
}
