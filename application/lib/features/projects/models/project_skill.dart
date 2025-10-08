/// Represents a `project_skill` entity from the database.
///
/// Links a project to a required skill, forming a many-to-many
/// relationship between projects and skills.
class ProjectSkill {
  /// Unique identifier of the project-skill relation.
  final int id;

  /// Timestamp when the relation was created.
  final DateTime createdAt;

  /// Identifier of the related project.
  final int projectId;

  /// Identifier of the linked skill.
  final int skillId;

  /// Creates an immutable [ProjectSkill] instance.
  const ProjectSkill({
    required this.id,
    required this.createdAt,
    required this.projectId,
    required this.skillId,
  });
}
