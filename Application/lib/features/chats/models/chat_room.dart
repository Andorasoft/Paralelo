/// Represents a `chat_room` entity from the database.
///
/// Defines a one-to-one chat between two users, linked to a proposal.
class ChatRoom {
  /// Unique identifier of the chat room (UUID).
  final String id;

  /// Timestamp when the chat was created.
  final DateTime createdAt;

  final bool isActive;

  /// Identifier of the first participant.
  final String user1Id;

  /// Identifier of the second participant.
  final String user2Id;

  /// Identifier of the linked proposal.
  final int proposalId;

  const ChatRoom({
    required this.id,
    required this.createdAt,
    this.isActive = true,
    required this.user1Id,
    required this.user2Id,
    required this.proposalId,
  });

  /// Builds a [ChatRoom] object from a database map.
  factory ChatRoom.fromMap(Map<String, dynamic> map) => ChatRoom(
    id: map['id'],
    createdAt: DateTime.parse(map['created_at']),
    isActive: map['is_active'],
    user1Id: map['user1_id'],
    user2Id: map['user2_id'],
    proposalId: map['proposal_id'],
  );
}
