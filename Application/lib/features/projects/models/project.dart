/// Represents a `project` entity from the database.
///
/// Stores project details created by users.
class Project {
  /// Unique identifier of the project.
  final int id;

  /// Timestamp when the project was created.
  final DateTime createdAt;

  /// Title of the project.
  final String title;

  /// Description of the project.
  final String description;

  /// Current status of the project.
  final String status;

  /// Optional additional requirement text.
  final String? requirement;

  final bool featured;

  final String visibilityPriority;

  /// UUID of the project owner.
  final String ownerId;

  /// Optional category identifier.
  final int? categoryId;

  const Project({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.status,
    this.requirement,
    required this.featured,
    required this.visibilityPriority,
    required this.ownerId,
    this.categoryId,
  });

  /// Builds a [Project] object from a database map.
  factory Project.fromMap(Map<String, dynamic> map) => Project(
    id: map['id'],
    createdAt: DateTime.parse(map['created_at']),
    title: map['title'],
    description: map['description'],
    status: map['status'],
    requirement: map['requirement'],
    featured: map['featured'],
    visibilityPriority: map['visibility_priority'],
    ownerId: map['owner_id'],
    categoryId: map['category_id'],
  );
}
