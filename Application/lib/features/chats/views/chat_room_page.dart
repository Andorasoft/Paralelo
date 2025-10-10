import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:paralelo/features/chats/controllers/chat_room_provider.dart';
import 'package:paralelo/features/chats/models/chat_room.dart';
import 'package:paralelo/features/chats/widgets/message_bubble.dart';
import 'package:paralelo/features/chats/widgets/message_input_bar.dart';
import 'package:paralelo/features/proposal/controllers/proposal_provider.dart';
import 'package:paralelo/features/proposal/models/proposal.dart';
import 'package:paralelo/features/user/controllers/app_user_provider.dart';
import 'package:paralelo/core/providers.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/user/models/app_user.dart';
import 'package:paralelo/features/user/widgets/user_rating.dart';
import 'package:paralelo/utils/formatters.dart';
import 'package:paralelo/widgets/loading_indicator.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  static const routeName = 'ChatRoomPage';
  static const routePath = '/chat-room';

  final String roomId;
  final String recipientId;

  const ChatRoomPage({
    super.key,
    required this.roomId,
    required this.recipientId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ChatRoomPageState();
  }
}

class ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<(AppUser, ChatRoom, Proposal)> _loadDataFuture;

  @override
  void initState() {
    super.initState();

    _loadDataFuture = _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(messagesProvider(widget.roomId));

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),

        child: FutureBuilder(
          future: _loadDataFuture,

          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return AppBar(
                automaticallyImplyLeading: false,

                title: const LoadingIndicator(showMessage: false).center(),
              );
            }

            final (user, _, _) = snapshot.data!;

            return AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 64.0,

              leading: IconButton(
                onPressed: () {
                  ref.read(goRouterProvider).pop();
                },
                icon: const Icon(LucideIcons.chevronLeft),
              ),

              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('${user.firstName} ${user.lastName}'.obscure()),
                  UserRating(rating: 4.5),
                ],
              ),

              bottom: PreferredSize(
                preferredSize: Size.fromHeight(36.0),

                child: TextButton(
                  onPressed: () {},

                  style: Theme.of(context).textButtonTheme.style?.copyWith(
                    backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    shape: WidgetStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    minimumSize: WidgetStateProperty.all(
                      const Size.fromHeight(36.0),
                    ),
                    maximumSize: WidgetStateProperty.all(
                      const Size.fromHeight(36.0),
                    ),
                  ),

                  child: const Text('Ver propuesta'),
                ).size(height: 36.0),
              ),
            );
          },
        ),
      ),

      body: Column(
        spacing: 8.0,

        children: [
          messagesAsync
              .when(
                data: (messages) => ListView.separated(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (_, i) {
                    final msg = messages[i];

                    return MessageBubble(
                      content: msg['text'] as String,
                      date:
                          (msg['created_at'] as Timestamp?)?.toDate() ??
                          DateTime.now(),
                      isFromCurrentUser:
                          msg['recipient_id'] == widget.recipientId,
                    );
                  },

                  separatorBuilder: (_, i) {
                    return const SizedBox(height: 8.0);
                  },
                ),
                loading: () => const CircularProgressIndicator().center(),
                error: (e, _) => Text('Error: $e').center(),
              )
              .expanded(),
          MessageInputBar(
            onSubmitted: (message) async {
              final user = ref.read(authProvider)!;
              await ChatService.sendMessage(
                roomId: widget.roomId,
                senderId: user.id,
                recipientId: widget.recipientId,
                text: message,
              );
            },
          ),
        ],
      ).useSafeArea().margin(const EdgeInsets.all(8.0)),
    ).hideKeyboardOnTap(context);
  }

  Future<(AppUser, ChatRoom, Proposal)> _loadData() async {
    final user = await ref.read(appUserProvider).getById(widget.recipientId);
    final room = await ref.read(chatRoomProvider).getById(widget.roomId);
    final proposal = await ref.read(proposalProvider).getById(room!.proposalId);

    return (user!, room, proposal!);
  }
}
