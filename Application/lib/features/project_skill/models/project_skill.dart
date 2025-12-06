/// Represents a `project_skill` entity from the database.
///
/// Links a project to a required skill, forming a many-to-many
/// relationship between projects and skills.
class ProjectSkill {
  /// Unique identifier of the project-skill relation.
  final String id;

  /// Timestamp when the relation was created.
  final DateTime createdAt;

  /// Identifier of the related project.
  final String projectId;

  /// Identifier of the linked skill.
  final String skillId;

  /// Creates an immutable [ProjectSkill] instance.
  const ProjectSkill({
    required this.id,
    required this.createdAt,
    required this.projectId,
    required this.skillId,
  });

  /// Builds a [ProjectSkill] object from a database map.
  factory ProjectSkill.fromMap(Map<String, dynamic> map) {
    return ProjectSkill(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      projectId: map['project_id'],
      skillId: map['skill_id'],
    );
  }
}
