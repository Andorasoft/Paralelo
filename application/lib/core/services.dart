import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

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

  Future<void> sendMessage(String roomId, String userId, String text) async {
    await _firestore.collection('chats').doc(roomId).collection('messages').add(
      {
        'text': text,
        'sender_id': userId,
        'created_at': FieldValue.serverTimestamp(),
      },
    );
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
}
