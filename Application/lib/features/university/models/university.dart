/// Represents a `university` entity from the database.
///
/// Stores institutional information for universities linked to users.
class University {
  /// Unique identifier of the university.
  final int id;

  /// Timestamp when the record was created.
  final DateTime createdAt;

  /// Full name of the university.
  final String name;

  /// Abbreviated or short name of the university.
  final String shortName;

  /// Domain of the university (e.g., "espoch.edu.ec").
  final String domain;

  /// City where the university is located.
  final String city;

  const University({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.shortName,
    required this.domain,
    required this.city,
  });

  /// Builds a [University] object from a database map.
  factory University.fromMap(Map<String, dynamic> map) {
    return University(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      name: map['name'],
      shortName: map['short_name'],
      domain: map['domain'],
      city: map['city'],
    );
  }
}
