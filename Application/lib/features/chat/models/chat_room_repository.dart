import 'package:supabase_flutter/supabase_flutter.dart';
import 'chat_room.dart';

abstract class ChatRoomRepository {
  Future<ChatRoom?> getById(String id);

  Future<List<ChatRoom>> getForUser(String userId);

  Future<ChatRoom?> getByProposal(String proposalId);

  Future<ChatRoom> create({
    required String user1Id,
    required String user2Id,
    required String proposalId,
  });
}

class SupabaseChatRoomRepository implements ChatRoomRepository {
  final SupabaseClient _client;

  const SupabaseChatRoomRepository(this._client);

  @override
  Future<ChatRoom?> getById(String id) async {
    final data = await _client
        .from('chat_room')
        .select()
        .eq('id', id)
        .maybeSingle();

    return data != null ? ChatRoom.fromMap(data) : null;
  }

  @override
  Future<List<ChatRoom>> getForUser(String userId) async {
    final data = await _client
        .from('chat_room')
        .select()
        .eq('is_active', true)
        .or('user1_id.eq.$userId,user2_id.eq.$userId');

    return data.map((i) => ChatRoom.fromMap(i)).toList();
  }

  @override
  Future<ChatRoom?> getByProposal(String proposalId) async {
    final data = await _client
        .from('chat_room')
        .select()
        .eq('proposal_id', proposalId)
        .maybeSingle();

    return data != null ? ChatRoom.fromMap(data) : null;
  }

  @override
  Future<ChatRoom> create({
    required String user1Id,
    required String user2Id,
    required String proposalId,
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

    return ChatRoom.fromMap(data);
  }
}
