/// Represents a `skill` entity from the database.
///
/// Defines a specific skill that can be linked to users or projects.
class Skill {
  /// Unique identifier of the skill.
  final String id;

  /// Timestamp when the skill record was created.
  final DateTime createdAt;

  /// Name of the skill (e.g., "Mathematics", "Flutter").
  final String name;

  /// Creates an immutable [Skill] instance.
  const Skill({required this.id, required this.createdAt, required this.name});

  /// Builds a [Skill] object from a database map.
  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      name: map['name'],
    );
  }
}
