import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paralelo/features/chats/models/chat_room_repository.dart';

final chatRoomProvider = Provider<ChatRoomRepository>((ref) {
  final client = Supabase.instance.client;
  return SupabaseChatRoomRepository(client);
});
