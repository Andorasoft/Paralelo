import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Background handler for FCM messages.
/// This will be triggered when the app is in the background or terminated.
@pragma('vm:entry-point')
Future<void> _messagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("📩 Background message received: ${message.messageId}");
}

/// Service for managing chat messages with Firestore.
class ChatService {
  static final _firestore = FirebaseFirestore.instance;

  ChatService._internal();

  /// Returns a stream of messages for a given chat room.
  ///
  /// [roomId] - ID of the chat room to listen to.
  static Stream<List<Map<String, dynamic>>> messagesStream(String roomId) {
    return _firestore
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  /// Sends a new message to a chat room.
  ///
  /// [roomId] - ID of the chat room.
  /// [senderId] - ID of the sender.
  /// [recipientId] - ID of the recipient.
  /// [text] - Message text.
  static Future<void> sendMessage(
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

/// Service for handling Firebase Cloud Messaging (FCM).
///
/// Implements a Singleton pattern to ensure only one instance is used
/// throughout the application.
class FCMService {
  /// Singleton instance.
  static final instance = FCMService._internal();

  final _messaging = FirebaseMessaging.instance;

  /// Private constructor for Singleton.
  FCMService._internal();

  /// Requests notification permissions (mainly for iOS).
  ///
  /// Returns `true` if permission is granted.
  Future<bool> requestPermissions() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  /// Retrieves the current device FCM token.
  ///
  /// Returns the token as a [String], or `null` if there was an error.
  Future<String?> getDeviceToken() async {
    try {
      String? token = await _messaging.getToken();
      debugPrint("📱 Device Token: $token");
      return token;
    } catch (e) {
      debugPrint("❌ Error retrieving FCM token: $e");
      return null;
    }
  }

  /// Listens for FCM token refresh events.
  ///
  /// [onRefresh] - Callback executed when the token is refreshed.
  void _listenTokenRefresh(Function(String) onRefresh) {
    _messaging.onTokenRefresh.listen((newToken) {
      debugPrint("🔄 New Device Token: $newToken");
      onRefresh(newToken);
    });
  }

  /// Listens for foreground and opened-app messages.
  ///
  /// [onMessage] - Called when a message is received in foreground.
  /// [onMessageOpenedApp] - Called when the user taps on a notification.
  void _listenMessages({
    void Function(RemoteMessage message)? onMessage,
    void Function(RemoteMessage message)? onMessageOpenedApp,
  }) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("📥 Foreground message: ${message.notification?.title}");
      onMessage?.call(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("📲 Notification opened: ${message.notification?.title}");
      onMessageOpenedApp?.call(message);
    });
  }

  /// Initializes FCM listeners and background handlers.
  ///
  /// [onMessage] - Callback for foreground messages.
  /// [onMessageOpenedApp] - Callback when user opens a notification.
  /// [onTokenRefresh] - Callback for when the FCM token changes.
  static Future<void> initialize({
    void Function(RemoteMessage message)? onMessage,
    void Function(RemoteMessage message)? onMessageOpenedApp,
    void Function(String token)? onTokenRefresh,
  }) async {
    await instance.getDeviceToken();

    if (onTokenRefresh != null) {
      instance._listenTokenRefresh(onTokenRefresh);
    }

    instance._listenMessages(
      onMessage: onMessage,
      onMessageOpenedApp: onMessageOpenedApp,
    );

    // Background message handler
    FirebaseMessaging.onBackgroundMessage(_messagingBackgroundHandler);
  }
}
