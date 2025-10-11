import 'package:paralelo/features/user/models/app_user.dart';

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

  /// Optional total project budget.
  final num? budget;

  /// Current status of the project (e.g., "open", "in_progress").
  final String status;

  /// Project category (e.g., "Tutoring", "Writing").
  final String category;

  /// Identifier of the project owner (user).
  final String ownerId;

  /// The [AppUser] object associated with this relation.
  final AppUser? owner;

  /// Creates an immutable [Project] instance.
  const Project({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.description,
    this.budget,
    required this.status,
    required this.category,
    required this.ownerId,
    this.owner,
  });

  /// Builds a [Project] object from a database map.
  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      title: map['title'],
      description: map['description'],
      budget: map['budget'],
      status: map['status'],
      category: map['category'],

      ownerId: map['owner_id'],
      owner: map['owner'] != null ? AppUser.fromMap(map['owner']) : null,
    );
  }
}
