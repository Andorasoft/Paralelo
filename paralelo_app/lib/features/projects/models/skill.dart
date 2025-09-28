/// Represents a `skill` entity from the database.
///
/// Defines a specific skill that can be linked to users or projects.
class Skill {
  /// Unique identifier of the skill.
  final int id;

  /// Timestamp when the skill record was created.
  final DateTime createdAt;

  /// Name of the skill (e.g., "Mathematics", "Flutter").
  final String name;

  /// Creates an immutable [Skill] instance.
  const Skill({required this.id, required this.createdAt, required this.name});

  /// Builds a [Skill] object from a database map.
  factory Skill.fromMap(Map<String, dynamic> map) => Skill(
    id: map['id'],
    createdAt: DateTime.parse(map['created_at']),
    name: map['name'],
  );

  /// Converts the [Skill] object into a map
  /// suitable for database storage or JSON encoding.
  Map<String, dynamic> toMap() => {
    'id': id,
    'created_at': createdAt.toIso8601String(),
    'name': name,
  };
}
