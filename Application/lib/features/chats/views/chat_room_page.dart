import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:paralelo/core/providers.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/core/services.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  static const routeName = 'ChatRoomPage';
  static const routePath = '/chat-room';

  final String roomId;

  const ChatRoomPage({super.key, required this.roomId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ChatRoomPageState();
  }
}

class ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _inputFieldController = TextEditingController();
  final _inputFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(messagesProvider(widget.roomId));

    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 0.0,

        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.0,

          children: [
            IconButton(
              onPressed: () {
                ref.read(goRouterProvider).pop();
              },
              icon: Icon(LucideIcons.chevronLeft),
            ),
            Text('J. R. C. C.'),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1.0),
        ),
      ),

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

      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16.0,

        children: [
          TextFormField(
            controller: _inputFieldController,
            focusNode: _inputFieldFocusNode,

            decoration: InputDecoration(hintText: 'Say something...'),
          ).expanded(),
          FilledButton.icon(
            onPressed: () async {
              await ChatService.sendMessage(
                widget.roomId,
                ref.read(authProvider)!.id,
                '',
                _inputFieldController.text,
              );
            },
            label: Icon(LucideIcons.send),
          ),
        ],
      ).margin(const EdgeInsets.symmetric(horizontal: 16.0)).useSafeArea(),
    ).hideKeyboardOnTap(context);
  }
}
