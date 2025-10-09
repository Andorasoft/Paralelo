import 'package:flutter_riverpod/flutter_riverpod.dart';
import './services.dart';

final messagesProvider =
    StreamProvider.family<List<Map<String, dynamic>>, String>((ref, roomId) {
      return ChatService.messagesStream(roomId);
    });
