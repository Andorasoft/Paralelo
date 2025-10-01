import 'package:flutter_riverpod/flutter_riverpod.dart';
import './services.dart';

final chatServiceProvider = Provider((ref) => ChatService());

final messagesProvider =
    StreamProvider.family<List<Map<String, dynamic>>, String>((ref, roomId) {
      final chatService = ref.watch(chatServiceProvider);
      return chatService.messagesStream(roomId);
    });
