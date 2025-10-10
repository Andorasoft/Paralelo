import 'package:supabase_flutter/supabase_flutter.dart';
import './chat_room.dart';

abstract class ChatRoomRepository {
  Future<List<ChatRoom>> getForUser(String userId);
  Future<ChatRoom?> getById(String id);
  Future<ChatRoom> create({
    required String user1Id,
    required String user2Id,
    required int proposalId,
  });
}

class SupabaseChatRoomRepository implements ChatRoomRepository {
  final SupabaseClient _client;

  const SupabaseChatRoomRepository(this._client);

  @override
  Future<List<ChatRoom>> getForUser(String userId) async {
    final data = await _client
        .from('chat_room')
        .select()
        .or('user1_id.eq.$userId,user2_id.eq.$userId');

    return data.map((i) => _fromMap(i)).toList();
  }

  @override
  Future<ChatRoom?> getById(String id) async {
    final data = await _client
        .from('chat_room')
        .select()
        .eq('id', id)
        .maybeSingle();

    return data != null ? _fromMap(data) : null;
  }

  @override
  Future<ChatRoom> create({
    required String user1Id,
    required String user2Id,
    required int proposalId,
  }) async {
    final data = await _client
        .from('chat_room')
        .insert({
          'user1_id': user1Id,
          'user2_id': user2Id,
          'proposal_id': proposalId,
        })
        .select()
        .single();

    return _fromMap(data);
  }

  /// Builds a [ChatRoom] object from a database map.
  ChatRoom _fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      user1Id: map['user1_id'],
      user2Id: map['user2_id'],
      proposalId: map['proposal_id'],
    );
  }
}
