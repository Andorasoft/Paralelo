/// Represents a `report` entity from the database.
///
/// Stores user-submitted reports related to projects or other users,
/// including the reason, status, and resolution details.
class Report {
  /// Unique identifier of the report.
  final int id;

  /// Timestamp when the report was created.
  final DateTime createdAt;

  /// Reason or description for the report.
  final String reason;

  /// Current status of the report (e.g., "OPEN", "RESOLVED").
  final String status;

  /// Optional resolution or moderator response.
  final String? resolution;

  /// UUID of the user who submitted the report.
  final String reporterId;

  /// UUID of the user being reported.
  final String reportedId;

  /// Optional ID of the related project (if applicable).
  final int? projectId;

  /// Creates an immutable [Report] instance.
  const Report({
    required this.id,
    required this.createdAt,
    required this.reason,
    required this.status,
    this.resolution,
    required this.reporterId,
    required this.reportedId,
    this.projectId,
  });

  /// Builds a [Report] object from a database map.
  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      reason: map['reason'],
      status: map['status'],
      resolution: map['resolution'],
      reporterId: map['reporter_id'],
      reportedId: map['reported_id'],
      projectId: map['project_id'],
    );
  }
}
