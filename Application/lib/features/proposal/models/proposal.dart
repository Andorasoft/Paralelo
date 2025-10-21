/// Represents a `proposal` entity from the database.
///
/// Stores service offers submitted by providers to projects.
class Proposal {
  /// Unique identifier of the proposal.
  final int id;

  /// Timestamp when the proposal was created.
  final DateTime createdAt;

  /// Message or description from the provider.
  final String message;

  /// Proposal mode (e.g., "FIXED", "HOURLY").
  final String mode;

  /// Optional fixed amount offered.
  final num? amount;

  /// Optional hourly rate offered.
  final num? hourlyRate;

  /// Numeric value of estimated duration.
  final num estimatedDurationValue;

  /// Unit of estimated duration (e.g., "DAYS", "HOURS").
  final String estimatedDurationUnit;

  /// Current status of the proposal.
  final String status;

  /// UUID of the provider submitting the proposal.
  final String providerId;

  /// Identifier of the related project.
  final int projectId;

  const Proposal({
    required this.id,
    required this.createdAt,
    required this.message,
    required this.mode,
    this.amount,
    this.hourlyRate,
    required this.estimatedDurationValue,
    required this.estimatedDurationUnit,
    required this.status,
    required this.providerId,
    required this.projectId,
  });

  /// Builds a [Proposal] object from a database map.
  factory Proposal.fromMap(Map<String, dynamic> map) => Proposal(
    id: map['id'],
    createdAt: DateTime.parse(map['created_at']),
    message: map['message'],
    mode: map['mode'],
    amount: map['amount'],
    hourlyRate: map['hourly_rate'],
    estimatedDurationValue: map['estimated_duration_value'],
    estimatedDurationUnit: map['estimated_duration_unit'],
    status: map['status'],
    providerId: map['provider_id'],
    projectId: map['project_id'],
  );
}
