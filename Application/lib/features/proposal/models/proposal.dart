import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/user/models/app_user.dart';

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
  final String providerId;

  /// Identifier of the related project.
  final int projectId;

  final AppUser? provider;

  /// The [Project] object associated with this relation.
  final Project? project;

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
    this.provider,
    this.project,
  });

  /// Builds a [Proposal] object from a database map.
  factory Proposal.fromMap(Map<String, dynamic> map) {
    return Proposal(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      message: map['message'],
      mode: map['mode'],
      amount: map['amount'],
      hourlyRate: map['hourly_rate'],
      status: map['status'],

      providerId: map['provider_id'],
      projectId: map['project_id'],
      provider: map['provider'] != null
          ? AppUser.fromMap(map['provider'])
          : null,
      project: map['project'] != null ? Project.fromMap(map['project']) : null,
    );
  }
}
