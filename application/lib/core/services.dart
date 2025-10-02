import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("📩 Mensaje en background: ${message.messageId}");
}

class ChatService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> messagesStream(String roomId) {
    return _firestore
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> sendMessage(
    String roomId,
    String senderId,
    String recipientId,
    String text,
  ) async {
    await _firestore
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .add({
          'text': text,
          'sender_id': senderId,
          'recipient_id': recipientId,
          'created_at': FieldValue.serverTimestamp(),
        });
  }
}

class FCMService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Request permissions (mainly for iOS)
  Future<bool> requestPermissions() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  /// Get current device token
  Future<String?> getDeviceToken() async {
    try {
      String? token = await _messaging.getToken();
      debugPrint("Device Token: $token");
      return token;
    } catch (e) {
      debugPrint("Error getting FCM token: $e");
      return null;
    }
  }

  /// Listen for token refresh
  void listenTokenRefresh(Function(String) onRefresh) {
    _messaging.onTokenRefresh.listen((newToken) {
      debugPrint("New Device Token: $newToken");
      onRefresh(newToken);
    });
  }

  void listenMessages({
    void Function(RemoteMessage message)? onMessage,
    void Function(RemoteMessage message)? onMessageOpenedApp,
  }) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("📥 Mensaje en foreground: ${message.notification?.title}");
      if (onMessage != null) onMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("📲 Notificación abierta: ${message.notification?.title}");
      if (onMessageOpenedApp != null) onMessageOpenedApp(message);
    });
  }

  /// Inicializar todo
  Future<void> initialize({
    void Function(RemoteMessage message)? onMessage,
    void Function(RemoteMessage message)? onMessageOpenedApp,
    void Function(String token)? onTokenRefresh,
  }) async {
    await requestPermissions();
    await getDeviceToken();

    if (onTokenRefresh != null) {
      listenTokenRefresh(onTokenRefresh);
    }
    listenMessages(
      onMessage: onMessage,
      onMessageOpenedApp: onMessageOpenedApp,
    );

    // Handler para mensajes en background
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}
