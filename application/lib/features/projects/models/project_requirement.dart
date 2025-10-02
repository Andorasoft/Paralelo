/// Represents a `project_requirement` entity from the database.
///
/// Stores a specific requirement or condition that belongs to a project.
class ProjectRequirement {
  /// Unique identifier of the requirement record.
  final int id;

  /// Timestamp when the requirement was created.
  final DateTime createdAt;

  /// Text description of the requirement.
  final String requirement;

  /// Identifier of the related project.
  final int projectId;

  /// Creates an immutable [ProjectRequirement] instance.
  const ProjectRequirement({
    required this.id,
    required this.createdAt,
    required this.requirement,
    required this.projectId,
  });
}
