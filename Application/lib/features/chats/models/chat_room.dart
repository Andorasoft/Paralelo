import 'package:paralelo/features/proposal/models/proposal.dart';
import 'package:paralelo/features/user/models/app_user.dart';

/// Represents a `chat_room` entity from the database.
///
/// Defines a chat session between two users, linked to a specific proposal.
class ChatRoom {
  /// Unique identifier of the chat room (UUID).
  final String id;

  /// Timestamp when the chat room was created.
  final DateTime createdAt;

  /// Identifier of the first participant (user).
  final String user1Id;

  /// The [AppUser] object associated with this relation.
  final AppUser? user1;

  /// Identifier of the second participant (user).
  final String user2Id;

  /// The [AppUser] object associated with this relation.
  final AppUser? user2;

  /// Identifier of the linked proposal (one chat per proposal).
  final int proposalId;

  /// The [Proposal] object associated with this relation.
  final Proposal? proposal;

  /// Creates an immutable [ChatRoom] instance.
  const ChatRoom({
    required this.id,
    required this.createdAt,
    required this.user1Id,
    required this.user2Id,
    required this.proposalId,
    this.user1,
    this.user2,
    this.proposal,
  });

  /// Builds a [ChatRoom] object from a database map.
  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),

      user1Id: map['user1_id'],
      user2Id: map['user2_id'],
      proposalId: map['proposal_id'],

      user1: map['user1'] != null ? AppUser.fromMap(map['user1']) : null,
      user2: map['user2'] != null ? AppUser.fromMap(map['user2']) : null,
      proposal: map['proposal'] != null
          ? Proposal.fromMap(map['proposal'])
          : null,
    );
  }
}
