/// Represents a `proposal` entity from the database.
///
/// Stores service offers submitted by providers to projects.
class Proposal {
  /// Unique identifier of the proposal.
  final String id;

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

  /// Estimated duration.
  final String? estimatedDuration;

  /// Current status of the proposal.
  final String status;

  /// UUID of the provider submitting the proposal.
  final String providerId;

  /// Identifier of the related project.
  final String projectId;

  const Proposal({
    required this.id,
    required this.createdAt,
    required this.message,
    required this.mode,
    this.amount,
    this.hourlyRate,
    this.estimatedDuration,
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
    estimatedDuration: map['estimated_duration'],
    status: map['status'],
    providerId: map['provider_id'],
    projectId: map['project_id'],
  );
}
