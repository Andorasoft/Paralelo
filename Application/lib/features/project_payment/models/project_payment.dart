/// Represents a `project_payment` entity from the database.
///
/// Stores payment details for a project, including min/max range,
/// currency, type, and relation to a specific project.
class ProjectPayment {
  /// Unique identifier of the payment record.
  final String id;

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
  final String projectId;

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

  /// Builds a [ProjectPayment] object from a database map.
  factory ProjectPayment.fromMap(Map<String, dynamic> map) {
    return ProjectPayment(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      min: (map['min'] as num).toDouble(),
      max: (map['max'] as num).toDouble(),
      currency: map['currency'],
      type: map['type'],
      projectId: map['project_id'],
    );
  }
}
