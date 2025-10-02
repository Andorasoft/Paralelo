import 'package:flutter_riverpod/flutter_riverpod.dart';
import './services.dart';

final chatServiceProvider = Provider((ref) => ChatService());

final messagesProvider =
    StreamProvider.family<List<Map<String, dynamic>>, String>((ref, roomId) {
      final chatService = ref.watch(chatServiceProvider);
      return chatService.messagesStream(roomId);
    });

final fcmServiceProvider = Provider<FCMService>((ref) {
  return FCMService();
});

final deviceTokenProvider = FutureProvider<String?>((
  FutureProviderRef<String?> ref,
) async {
  final fcmService = ref.read(fcmServiceProvider);

  final granted = await fcmService.requestPermissions();
  if (!granted) return null;

  final token = await fcmService.getDeviceToken();

  // Escuchar refresh → invalidar
  fcmService.listenTokenRefresh((newToken) {
    ref.invalidateSelf(); // fuerza a recargar este provider
  });

  return token;
});
