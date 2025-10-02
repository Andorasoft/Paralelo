import 'package:cloud_firestore/cloud_firestore.dart';

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
