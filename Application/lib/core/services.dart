import 'imports.dart';

/// Background handler for FCM messages.
/// This will be triggered when the app is in the background or terminated.
@pragma('vm:entry-point')
Future<void> _messagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("📩 Background message received: ${message.messageId}");
}

/// Service for managing chat messages with Firestore.
class ChatService {
  /// Singleton instance.
  static final instance = ChatService._internal();

  final _firestore = FirebaseFirestore.instance;

  /// Private constructor for Singleton.
  ChatService._internal();

  /// Returns a stream of messages for a given chat room.
  ///
  /// [roomId] - ID (UUID) of the chat room to listen to.
  Stream<List<Map<String, dynamic>>> messagesStream(String roomId) {
    return _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  /// Stream that emits unread map for a given chat room.
  Stream<Map<String, dynamic>?> unreadStream(String roomId) {
    return _firestore
        .collection('rooms')
        .doc(roomId)
        .snapshots()
        .map((doc) => doc.data()?['unread'] as Map<String, dynamic>?);
  }

  /// Sends a new message to a chat room and updates unread flags.
  ///
  /// [roomId] - ID of the chat room.
  /// [senderId] - ID of the sender (UUID).
  /// [recipientId] - ID of the recipient (UUID).
  /// [text] - Message text.
  Future<void> sendMessage({
    required String roomId,
    required String senderId,
    required String recipientId,
    required String text,
  }) async {
    final roomRef = _firestore.collection('rooms').doc(roomId);
    final messagesRef = roomRef.collection('messages');

    // Add message
    await messagesRef.add({
      'text': text,
      'sender': senderId,
      'recipient': recipientId,
      'timestamp': FieldValue.serverTimestamp(), // matches JSON format
    });

    // Update unread status in room document
    await roomRef.set({
      'unread': {
        senderId: false, // the sender has read
        recipientId: true, // recipient has new unread message
      },
    }, SetOptions(merge: true));
  }

  /// Marks messages as read for a specific user in a room.
  Future<void> markAsRead({
    required String roomId,
    required String userId,
  }) async {
    final roomRef = _firestore.collection('rooms').doc(roomId);
    await roomRef.update({'unread.$userId': false});
  }

  /// Returns the unread status for a chat room.
  Future<Map<String, dynamic>?> getUnreadStatus(String roomId) async {
    final doc = await _firestore.collection('rooms').doc(roomId).get();
    return doc.data()?['unread'] as Map<String, dynamic>?;
  }

  Future<void> deleteChatRoom(String roomId) async {
    final roomRef = _firestore.collection('rooms').doc(roomId);
    final messagesRef = roomRef.collection('messages');

    while (true) {
      final snapshot = await messagesRef.limit(500).get();
      if (snapshot.docs.isEmpty) break;

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }

    await roomRef.delete();
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

  /// Checks the current notification permission status.
  ///
  /// Returns `true` if the user has granted notification permissions,
  /// otherwise returns `false`.
  ///
  /// On iOS, this method does **not** prompt the user — it only retrieves
  /// the current authorization status from the system.
  ///
  /// On Android, this typically returns `true` unless the user has
  /// explicitly disabled notifications for the app.
  Future<bool> checkPermission() async {
    final settings = await _messaging.getNotificationSettings();

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
