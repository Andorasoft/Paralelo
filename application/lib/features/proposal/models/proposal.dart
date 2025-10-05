/// Represents a `proposal` entity from the database.
///
/// Stores details of a proposal submitted by a provider to a project.
class Proposal {
  /// Unique identifier of the proposal.
  final int id;

  /// Timestamp when the proposal was created.
  final DateTime createdAt;

  /// Message or description provided by the proposer.
  final String message;

  /// Proposal mode (e.g., "fixed", "hourly").
  final String mode;

  /// Optional fixed amount proposed.
  final num? amount;

  /// Optional hourly rate proposed.
  final num? hourlyRate;

  /// Current status of the proposal (e.g., "pending", "accepted").
  final String status;

  /// Identifier of the provider (user) who submitted the proposal.
  final int providerId;

  /// Identifier of the related project.
  final int projectId;

  /// Creates an immutable [Proposal] instance.
  const Proposal({
    required this.id,
    required this.createdAt,
    required this.message,
    required this.mode,
    this.amount,
    this.hourlyRate,
    required this.status,
    required this.providerId,
    required this.projectId,
  });
}
