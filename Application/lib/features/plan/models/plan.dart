/// Represents a `plan` entity from the database.
///
/// Defines subscription tiers and feature limits for users.
class Plan {
  /// Unique identifier of the plan.
  final int id;

  /// Timestamp when the plan record was created.
  final DateTime createdAt;

  /// Name of the plan (e.g., "Free", "Pro", "Premium").
  final String name;

  /// Optional description of the plan.
  final String? description;

  /// Monthly or yearly price of the plan.
  final num price;

  /// Unit of the billing period (e.g., "MONTH", "YEAR").
  final String periodUnit;

  /// Maximum number of proposals allowed per week.
  final int proposalsPerWeek;

  /// Maximum number of active projects allowed.
  final int? activeProjectsLimit;

  /// Maximum number of featured projects allowed.
  final int? featuredProjectsLimit;

  /// Maximum number of ongoing projects allowed.
  final int? ongoingProjectsLimit;

  /// Optional plan tag (e.g., "-", "PRO", "PREMIUM").
  final String? tag;

  /// Support level offered with the plan (e.g., "BASIC", "PRIORITY").
  final String supportLevel;

  /// Whether performance metrics are included.
  final bool performanceMetrics;

  /// Visibility priority for the user (e.g., "LOW", "MEDIUM", "HIGH").
  final String visibilityPriority;

  /// Whether the user can highlight services.
  final bool highlightServices;

  /// Whether the plan is currently active and available.
  final bool isActive;

  const Plan({
    required this.id,
    required this.createdAt,
    required this.name,
    this.description,
    required this.price,
    required this.periodUnit,
    required this.proposalsPerWeek,
    this.activeProjectsLimit,
    this.featuredProjectsLimit,
    this.ongoingProjectsLimit,
    this.tag,
    required this.supportLevel,
    required this.performanceMetrics,
    required this.visibilityPriority,
    required this.highlightServices,
    required this.isActive,
  });

  /// Builds a [Plan] object from a database map.
  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      name: map['name'],
      description: map['description'],
      price: map['price'],
      periodUnit: map['period_unit'],
      proposalsPerWeek: map['proposals_per_week'],
      activeProjectsLimit: map['active_projects_limit'],
      featuredProjectsLimit: map['featured_projects_limit'],
      ongoingProjectsLimit: map['ongoing_projects_limit'],
      tag: map['tag'],
      supportLevel: map['support_level'],
      performanceMetrics: map['performance_metrics'],
      visibilityPriority: map['visibility_priority'],
      highlightServices: map['highlight_services'],
      isActive: map['is_active'],
    );
  }
}
