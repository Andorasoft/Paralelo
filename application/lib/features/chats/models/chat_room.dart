/// Represents a `chat_room` entity from the database.
///
/// Defines a chat session between two users, linked to a specific proposal.
class ChatRoom {
  /// Unique identifier of the chat room (UUID).
  final String id;

  /// Timestamp when the chat room was created.
  final DateTime createdAt;

  /// Identifier of the first participant (user).
  final int user1Id;

  /// Identifier of the second participant (user).
  final int user2Id;

  /// Identifier of the linked proposal (one chat per proposal).
  final int proposalId;

  /// Creates an immutable [ChatRoom] instance.
  const ChatRoom({
    required this.id,
    required this.createdAt,
    required this.user1Id,
    required this.user2Id,
    required this.proposalId,
  });
}
