/// Represents a `category` entity from the database.
///
/// Defines an academic or service category that projects can belong to.
class Category {
  /// Unique identifier of the category.
  final int id;

  /// Timestamp when the category record was created.
  final DateTime createdAt;

  /// Name of the category (e.g., "Mathematics", "Writing").
  final String name;

  /// Optional description of the category.
  final String? description;

  const Category({
    required this.id,
    required this.createdAt,
    required this.name,
    this.description,
  });

  /// Builds a [Category] object from a database map.
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      name: map['name'],
      description: map['description'],
    );
  }
}
