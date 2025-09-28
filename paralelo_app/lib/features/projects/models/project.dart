/// Represents a `project` entity from the database.
///
/// Stores general information about a project, including
/// title, description, budget, status, and owner.
class Project {
  /// Unique identifier of the project.
  final int id;

  /// Timestamp when the project was created.
  final DateTime createdAt;

  /// Project title.
  final String title;

  /// Detailed project description.
  final String description;

  /// Mode of the project (e.g., "fixed", "hourly").
  final String mode;

  /// Optional total project budget.
  final num? budget;

  /// Optional maximum hourly rate.
  final num? maxHourlyRate;

  /// Current status of the project (e.g., "open", "in_progress").
  final String status;

  /// Project category (e.g., "Tutoring", "Writing").
  final String category;

  /// Identifier of the project owner (user).
  final int ownerId;

  /// Creates an immutable [Project] instance.
  const Project({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.mode,
    this.budget,
    this.maxHourlyRate,
    required this.status,
    required this.category,
    required this.ownerId,
  });

  /// Converts the [Project] object into a map
  /// suitable for database storage or JSON encoding.
  Map<String, dynamic> toMap() => {
    'id': id,
    'created_at': createdAt.toIso8601String(),
    'title': title,
    'description': description,
    'mode': mode,
    'budget': budget,
    'max_hourly_rate': maxHourlyRate,
    'status': status,
    'category': category,
    'owner_id': ownerId,
  };
}
