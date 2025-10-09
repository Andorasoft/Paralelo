import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paralelo/features/chats/models/chat_room_repository.dart';
import 'package:paralelo/features/chats/models/chat_room.dart';

final chatRoomProvider = Provider((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseChatRoomRepository(client);

  return _ChatRoomProvider(repo);
});

class _ChatRoomProvider {
  final ChatRoomRepository _repo;

  const _ChatRoomProvider(this._repo);

  Future<List<ChatRoom>> getForUser(String userId) {
    return _repo.getForUser(userId);
  }

  Future<ChatRoom> create({
    required String user1Id,
    required String user2Id,
    required int proposalId,
  }) {
    return _repo.create(
      user1Id: user1Id,
      user2Id: user2Id,
      proposalId: proposalId,
    );
  }
}
