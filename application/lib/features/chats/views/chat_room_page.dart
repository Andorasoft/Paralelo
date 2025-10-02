import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paralelo/core/providers.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  static const routeName = 'ChatRoomPage';
  static const routePath = '/chat-room';

  final String roomId;

  const ChatRoomPage({super.key, required this.roomId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ChatRoomPageState();
  }
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(messagesProvider(widget.roomId));

    return Scaffold(
      key: scaffoldKey,

      body: messagesAsync.when(
        data: (messages) => ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (_, i) {
            final msg = messages[i];
            return ListTile(
              title: Text(msg['text'] ?? ''),
              subtitle: Text(msg['senderId'] ?? ''),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    ).hideKeyboardOnTap(context);
  }
}
