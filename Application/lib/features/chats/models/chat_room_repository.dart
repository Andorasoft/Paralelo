import 'package:supabase_flutter/supabase_flutter.dart';
import './chat_room.dart';

abstract class ChatRoomRepository {
  Future<List<ChatRoom>> getForUser(
    String userId, {
    required bool includeRelations,
  });

  Future<ChatRoom?> getById(String id, {required bool includeRelations});

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
  Future<List<ChatRoom>> getForUser(
    String userId, {
    required bool includeRelations,
  }) async {
    final data = await _client
        .from('chat_room')
        .select(
          includeRelations
              ? '*, proposal(*), user1:app_user!chat_room_user1_id_fkey(*), user2:app_user!chat_room_user2_id_fkey(*)'
              : '*',
        )
        .or('user1_id.eq.$userId,user2_id.eq.$userId');

    return data.map((i) => ChatRoom.fromMap(i)).toList();
  }

  @override
  Future<ChatRoom?> getById(String id, {required bool includeRelations}) async {
    final data = await _client
        .from('chat_room')
        .select(
          includeRelations
              ? '*, proposal(*), user1:app_user!chat_room_user1_id_fkey(*), user2:app_user!chat_room_user2_id_fkey(*)'
              : '*',
        )
        .eq('id', id)
        .maybeSingle();

    return data != null ? ChatRoom.fromMap(data) : null;
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

    return ChatRoom.fromMap(data);
  }
}
