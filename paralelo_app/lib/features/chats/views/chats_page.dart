import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paralelo/core/providers.dart';

class ChatsPage extends ConsumerWidget {
  static const routeName = 'ChatsPage';
  static const routePath = '/chats';

  final String roomId;

  const ChatsPage({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(messagesProvider(roomId));

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
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
    );
  }
}
